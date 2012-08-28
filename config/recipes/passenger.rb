namespace :passenger do
	desc "Install the passenger gem"
	task :install do
		run "rvm ree"
		run "gem install passenger"
	end

	desc "Install nginx through passenger"
	task :install_nginx do 
		#run "#{rvmsudo} passenger-install-nginx-module"
	end

	after "deploy:install", "passenger:install"
	after "passenger:install", "passenger:install_nginx"
end