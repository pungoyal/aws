namespace :servers do
  task :list do
    connection = Fog::Compute.new({:provider => 'AWS', :region => AWS::Config.region, :aws_secret_access_key => AWS::Config.aws_secret_access_key, :aws_access_key_id => AWS::Config.aws_access_key_id})
    p connection.servers
  end

  task :boot do
    connection = Fog::Compute.new({:provider => 'AWS', :region => AWS::Config.region, :aws_secret_access_key => AWS::Config.aws_secret_access_key, :aws_access_key_id => AWS::Config.aws_access_key_id})

    key_pairs = connection.key_pairs
    key_pair = key_pairs.find { |k| k.name == AWS::Config.key_name }

    if key_pair
      p "** key pair #{AWS::Config.key_name} already exists"
    else
      create_key_pair(AWS::Config.key_name)
      p "** created key pair #{AWS::Config.key_name}"
    end
  end

  def create_key_pair key_name
    p "FAIL FAIL FAIL"
    raise Application.Exception
  end
end
