namespace :redis do
	desc "Install redis-server"
	task :install do
		run "#{sudo} apt-get -y install redis-server"
	end
end