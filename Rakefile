require File.expand_path('../config/environment', __FILE__)

Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }

desc "servers:list"
task :default => ["servers:list"]

desc "test the env setup"
task :noop

desc "get off the ground"
task :bootstrap => ['config:create']
