module Capistrano
  module DSL
    # Capistrano Aws module.
    module Aws
      def aws_ec2
        Capistrano::Aws::EC2::EC2.instance
      end

      def aws_ec2_register(options = {})
        aws_ec2.instances.each do |_id, instance|
          ip = Capistrano::Aws::EC2.contact_point(instance)
          roles = Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_roles_tag)).split(',')

          server ip, options.merge(roles: roles, aws_instance_id: instance.id)
        end
      end
    end
  end
end
