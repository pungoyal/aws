namespace :platform do
  desc "instantiate the platform"
  task :boot do
    ensure_presence_of_key_pair AWS::Config.key_name
    ensure_presence_of_security_group AWS::Config.security_group_name

    create_and_wait_for_server AWS::Config.key_name, AWS::Config.security_group_name
    Rake::Task["servers:list"].invoke
  end

  def create_and_wait_for_server key_name, security_group
    server = $connection.servers.create :key_name => key_name, :groups => [security_group]
    server.wait_for { ready? }
    puts "server is booted up -> #{server.id}".green
    puts "ssh -i ~/.ssh/#{key_name}.pem ubuntu@#{server.dns_name}".blue
  end

  def ensure_presence_of_key_pair key_name
    key_pairs = $connection.key_pairs
    key_pair = key_pairs.find { |k| k.name == key_name } || create_key_pair(key_name)
    puts "Key pair -> #{key_pair.name}".green
    key_pair.name
  end

  def ensure_presence_of_security_group group_name
    security_groups = $connection.security_groups
    security_group = security_groups.find { |g| g.name == group_name } || create_security_group(group_name)
    puts "security group -> #{security_group.name}:#{security_group.group_id}".green
    security_group.group_id
  end

  def create_key_pair key_name
    puts "created key pair #{key_name}".blue
    raise Application.Exception
  end

  def create_security_group group_name
    puts "created key pair #{group_name}".blue
    raise Application.Exception
  end
end
