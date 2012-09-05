require "rvm/capistrano"

set :rvm_ruby_string, "1.8.7"
set :rvm_install_with_sudo, true
set :rvm_type, :user

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

set_default :ruby_version, "ree"

namespace :rvm do
  desc "Install Rvm, Ruby, and the Bundler gem"
  task :install, :roles => :app do
    # "rvm:install_rvm"
    # run "curl -L https://get.rvm.io | bash -s stable"
    # bashrc =<<-BASHRC
    #   '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function'
    # BASHRC
    # run "echo #{bashrc} >> ~/.bashrc"
    # run "echo #{bashrc} >> ~/.profile"
    # bashrc = <<-BASHRC
    #  	if [ -d $HOME/.rvm ]; then 
    #    	export PATH="$HOME/.rvm/bin:$PATH" 
    # 	fi
    # BASHRC
    # put bashrc, "/tmp/rvmrc"
    # run "exec /home/#{user}/.rvm/scripts/rvm"
    # run "cat /tmp/rvmrc ~/.bashrc > ~/.bashrc.tmp"
    # run "mv ~/.bashrc.tmp ~/.bashrc"
    # run %q{export PATH="$HOME/.rvm/bin:$PATH"}    
    # run "exec /home/#{user}/.rvm/scripts/rvm"
  end
  
  desc "Install rvm readline package"
  task :install_pkg, :roles => :web do
    #run "rvm pkg install readline"
  end

  desc "Install bundler gem"
  task :install_bundler, :roles => :web do
  	#run "rvm --default use #{ruby_version}"
    #run "rvm #{ruby_version}"
    run "gem install bundler --no-ri --no-rdoc"
  end

  #after "deploy:install", "rvm:install"
  #after "rvm:install", "rvm:install_pkg"
  #before "rvm:install",      "rvm:install_rvm"
  after  "rvm:install",  "rvm:install_ruby"
  after  "rvm:install_ruby", "rvm:create_gemset"
  after  "rvm:install",      "rvm:install_bundler"
end
