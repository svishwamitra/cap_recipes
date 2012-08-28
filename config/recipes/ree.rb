namespace :ree do
	desc "Install ruby version"
	task :install, :roles => :web do
		run "#{sudo} apt-get -y install ree"
	end
end