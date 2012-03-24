namespace :servers do
  task :list do
    connection = Fog::Compute.new({
                                      :provider => 'AWS',
                                      :region => AWS::Config.region,
                                      :aws_secret_access_key => AWS::Config.aws_secret_access_key,
                                      :aws_access_key_id => AWS::Config.aws_access_key_id
                                  })
    p connection.servers
  end
end
