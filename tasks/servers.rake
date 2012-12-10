namespace :servers do
  task :list do
    servers = $connection.servers
    if servers.count > 0
      servers.each do |server|
        puts "#{server.id} : #{server.dns_name} : #{server.state} : #{server.created_at}".light_blue
      end
    else
      puts "nothing to see here. move on!".green
    end
  end

  desc "kill all servers"
  task :kill_all do
    servers = $connection.servers
    servers.each do |server|
      unless server.state == "terminated"
        puts "killing #{server.dns_name} ...".red
        server.destroy
      end
    end
    Rake::Task["servers:list"].invoke
  end
end
