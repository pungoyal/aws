namespace :platform do
  desc "instantiate the platform"
  task :boot do
    ensure_presence_of_key_pair AWS::Config.key_name
    security_group_id = ensure_presence_of_security_group AWS::Config.security_group_name

    create_and_wait_for_server AWS::Config.key_name, security_group_id
    Rake::Task["servers:list"].invoke
  end

  def create_and_wait_for_server key_name, security_group_id
    options = {
        :key_name => AWS::Config.key_name,
        :security_group_ids => [security_group_id],
        :image_id => AWS::Config.image_id,
        :flavor_id => AWS::Config.flavor_id,
    }

    puts "instantiating a server with => #{options} ... ".cyan

    server = $connection.servers.create options
    server.wait_for { ready? }

    commands = ["sudo aptitude install htop"]
    ssh_options = {key_data: File.read("/Users/puneet/.ssh/#{key_name}.pem")}
    server.ssh commands, ssh_options

    puts "server is booted up -> #{server.id}".green
    puts "ssh -i ~/.ssh/#{server.key_name}.pem ubuntu@#{server.dns_name}".blue
  end

  def ensure_presence_of_key_pair key_name
    key_pairs = $connection.key_pairs
    key_pair = key_pairs.find { |k| k.name == key_name } || create_key_pair(key_name)
    puts "Key pair -> #{key_pair.name}".cyan
    key_pair.name
  end

  def ensure_presence_of_security_group group_name
    security_groups = $connection.security_groups
    security_group = security_groups.find { |g| g.name == group_name } || create_security_group(group_name)
    puts "security group -> #{security_group.name}:#{security_group.group_id}".cyan
    security_group.group_id
  end

  def create_key_pair key_name
    puts "created key pair #{key_name}".blue
    raise Application.Exception
  end

  def create_security_group group_name
    puts "created security group #{group_name}".blue
    raise Application.Exception
  end
end
