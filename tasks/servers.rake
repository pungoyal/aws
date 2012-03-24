namespace :servers do
  task :list do
    connection = Fog::Compute.new({:provider => 'AWS', :region => AWS::Config.region, :aws_secret_access_key => AWS::Config.aws_secret_access_key, :aws_access_key_id => AWS::Config.aws_access_key_id})
    servers = connection.servers
    if servers.count > 0
      servers.each do |server|
        puts "#{server.id} : #{server.dns_name} : #{server.state} : #{server.created_at}".blue
      end
    else
      puts "nothing to see here. move on!".colorize(:green)
    end
  end
end
