require 'singleton'
require 'aws-sdk'

module Capistrano
  module Aws
    # EC2 module.
    module EC2
      # Handle EC2.
      class EC2
        include Singleton

        def initialize
          @ec2 = {}

          regions.each do |region|
            @ec2[region] = ::Aws::EC2::Resource.new(region: region)
          end
        end

        def regions
          fetch(:aws_ec2_regions)
        end

        def instances
          application = fetch(:aws_ec2_application)
          raise 'application not set.' if application.nil?

          instances = {}

          filters = [
            {
              name: "tag:#{fetch(:aws_ec2_application_tag)}",
              values: [fetch(:aws_ec2_application)]
            },
            {
              name: "tag:#{fetch(:aws_ec2_stage_tag)}",
              values: [fetch(:aws_ec2_stage)]
            },
            {
              name: 'instance-state-name',
              values: ['running']
            }
          ]

          @ec2.each do |_region, client|
            client.instances(filters: filters).each do |instance|
              instances[instance.id] = instance
            end
          end

          instances
        end
      end

      def self.contact_point(instance)
        case fetch(:aws_ec2_contact_point)
        when :private_ip
          instance.private_ip_address
        when :public_dns
          instance.public_dns_name
        else
          instance.public_ip_address
        end
      end

      def self.parse_tag(instance, tag_name)
        tag = instance.tags.select { |instance_tag| instance_tag.key == tag_name }.first

        if tag.nil?
          ''
        else
          tag.value
        end
      end
    end
  end
end
