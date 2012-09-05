namespace :passenger do
	desc "Install the passenger gem"
	task :install, :roles => :web do
		#run "rvm ree"
		run "gem install passenger"
	end

	desc "Install nginx through passenger"
	task :install_nginx, :roles => :web do 
		run "#{rvmsudo} passenger-install-nginx-module"
	end

	after "deploy:install", "passenger:install"
	after "passenger:install", "passenger:install_nginx"
end