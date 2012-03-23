require File.expand_path('../config/environment', __FILE__)

Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }

task :default => ["servers:list"]

task :noop
task :bootstrap => ['config:create']
