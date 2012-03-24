namespace :servers do
  task :list do
    servers = $connection.servers
    if servers.count > 0
      servers.each do |server|
        puts "#{server.id} : #{server.dns_name} : #{server.state} : #{server.created_at}".blue
      end
    else
      puts "nothing to see here. move on!".colorize(:green)
    end
  end

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
