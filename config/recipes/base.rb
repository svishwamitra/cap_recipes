def template(from, to)
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  put ERB.new(erb).result(binding), to
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y dist-upgrade"
    run "#{sudo} apt-get install curl git-core build-essential zlib1g-dev libssl-dev tar"
		run "#{sudo} apt-get install libreadline6-dev libc6 libpcre3 libssl0.9.8 zlib1g"
		run "#{sudo} apt-get install libxml2 libxml2-dev libxml2-utils libxslt libxslt-dev"
    run "#{sudo} apt-get -y install python-software-properties"
    run "#{sudo} apt-get install libcurl4-openssl-dev"
  end
end
