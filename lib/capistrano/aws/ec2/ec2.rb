require 'singleton'
require 'aws-sdk-ec2'

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
          instances = {}

          filters = fetch(:aws_ec2_default_filters)

          filters.concat fetch(:aws_ec2_extra_filters)

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
        when :private_dns
          instance.private_dns_name
        when :id
          instance.id
        when :public_dns
          instance.public_dns_name
        when :ipv_6_address
          "[#{instance.ipv_6_address}]"
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
