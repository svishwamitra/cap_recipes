namespace :redis do
	desc "Install redis-server"
	task :install do
		run "#{sudo} apt-get install redis-server"
	end
end