require "bundler/capistrano"

set :stages, %w(ruby basic)
#set :default_stage, "base"
require 'capistrano/ext/multistage'

server "192.168.167.178", :app, :web
server "192.168.167.178", :db, :primary => true
#set :port, 300

set :user, "sachin"
set :application, "ces"
set :deploy_to, "/home/#{user}/applications/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :server_name_nginx, "compliancemanageronline.com"

set :scm, "git"
set :repository, "git@github.com:svishwamitra/ces.git"
set :branch do
  default_tag = 'git tag'.split("\n").last
  tag = Capistrano::CLI.ui.ask "Tag to deploy (make sure to push the tag first): [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end

set :whenever_command, "bundle exec whenever ."

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  desc "Symlink shared configs and folders on each release."
    task :symlink_shared do
      run "ln -nfs #{shared_path}/attachments #{release_path}/attachments"
      run "mv #{release_path}/config/environment.rb #{release_path}/config/environment.rb.backup"
      run "mv #{release_path}/config/environments/production.rb #{release_path}/config/environments/production.rb.backup"
      run "mv #{release_path}/config/appconfig/setup.yml #{release_path}/config/appconfig/setup.yml.backup"
      run "mv #{release_path}/config/appconfig/resque.yml #{release_path}/config/appconfig/resque.yml.backup"
      run "cp -f #{shared_path}/environment.rb.test #{release_path}/config/environment.rb"
      run "cp -f #{shared_path}/production.rb.test #{release_path}/config/environments/production.rb"
      run "cp -f #{shared_path}/setup.yml.test #{release_path}/config/appconfig/setup.yml"
      run "cp -f #{shared_path}/database.yml #{release_path}/config/database.yml"
      run "cp -f #{shared_path}/resque.yml.test #{release_path}/config/appconfig/resque.yml"
    end
end

after 'deploy:create_symlink', 'deploy:symlink_shared'
after "deploy", "deploy:migrate"
