namespace :platform do
  desc "instantiate the platform"
  task :boot do
    @connection = Fog::Compute.new({:provider => 'AWS', :region => AWS::Config.region, :aws_secret_access_key => AWS::Config.aws_secret_access_key, :aws_access_key_id => AWS::Config.aws_access_key_id})
    ensure_presence_of_key_pair AWS::Config.key_name
    ensure_presence_of_security_group AWS::Config.security_group_name
  end

  def ensure_presence_of_security_group group_name

  end

  def ensure_presence_of_key_pair key_name
    key_pairs = @connection.key_pairs
    key_pair = key_pairs.find { |k| k.name == key_name }
    if key_pair
      puts "key pair #{key_name} already exists".green
    else
      create_key_pair(key_name)
    end
  end

  def create_key_pair key_name
    puts "created key pair #{key_name}".blue
    raise Application.Exception
  end
end
