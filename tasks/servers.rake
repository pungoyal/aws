namespace :servers do
  task :list do
    connection = Fog::Compute.new({:provider => 'AWS', :region => AWS::Config.region, :aws_secret_access_key => AWS::Config.aws_secret_access_key, :aws_access_key_id => AWS::Config.aws_access_key_id})
    servers = connection.servers
    if servers.count > 0
      servers.each do |server|
        p "#{server.dns_name} : #{server.state} : #{server.key_name}"
      end
    else
      p "nothing to see here. move on!"
    end
  end
end
