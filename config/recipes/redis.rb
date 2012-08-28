namespace :redis do
	desc "Install redis-server"
	task :install, :roles => :web do
		run "#{sudo} apt-get -y install redis-server"
	end
end