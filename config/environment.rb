ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

module AWS
  module Config
    class << self
      attr_accessor :aws_secret_access_key,
                    :aws_access_key_id,
                    :region,
                    :key_name,
                    :security_group_name
    end
  end

  class << self
    def root(*more)
      File.expand_path File.join(File.dirname(__FILE__), '..', *more)
    end
  end
end

config = YAML.load_file AWS.root('config', 'aws.yml')

AWS::Config.aws_secret_access_key = config["aws_secret_access_key"]
AWS::Config.aws_access_key_id = config["aws_access_key_id"]
AWS::Config.region = config["region"]
AWS::Config.key_name = config["key_name"]
AWS::Config.security_group_name = config["security_group_name"]

$connection = Fog::Compute.new({:provider => 'AWS', :region => AWS::Config.region, :aws_secret_access_key => AWS::Config.aws_secret_access_key, :aws_access_key_id => AWS::Config.aws_access_key_id})
