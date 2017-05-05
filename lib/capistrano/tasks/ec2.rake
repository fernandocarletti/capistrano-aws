require 'capistrano/aws/ec2/instances_table'

namespace :aws do
  namespace :ec2 do
    desc 'List available instances.'
    task :instances do
      Capistrano::Aws::EC2::InstancesTable.new(aws_ec2.instances).render
    end
  end
end
