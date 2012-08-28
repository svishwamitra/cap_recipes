namespace :delayed do
  desc "To restart delayed job and whenever for update crontab"
  task :restart_daemons, :roles => :app do
    system "sudo /etc/init.d/redis-server restart"
    rake_path = `which rake`
    system "ps aux | grep resque:work | awk '{ print \"kill -9 \" $2 }'| bash"
    system "cd #{current_path} && bundle exec #{rake_path.chomp} resque:work QUEUE='*' BACKGROUND=yes COUNT=3"
  end
end

after "deploy:restart", "delayed:restart_daemons"
