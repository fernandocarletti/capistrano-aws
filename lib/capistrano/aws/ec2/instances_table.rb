require 'terminal-table'
require 'rainbow'

module Capistrano
  module Aws
    module EC2
      # Generates instances table.
      class InstancesTable
        def initialize(instances)
          @instances = instances.sort_by do |_id, instance|
            Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_name_tag))
          end
        end

        def render
          table = Terminal::Table.new(
            style: {
              border_x: '',
              border_i: '',
              border_y: ''
            }
          )

          table.add_row header_row

          number = 1
          @instances.each do |_id, instance|
            table.add_row instance_row(number, instance)
            number += 1
          end

          puts table
        end

        def header_row
          [
            Rainbow('Num').bright,
            Rainbow('ID').bright,
            Rainbow('Name').bright,
            Rainbow('Type').bright,
            Rainbow('Contact Point').bright,
            Rainbow('Availability Zone').bright,
            Rainbow('Roles').bright,
            Rainbow('Stages').bright
          ]
        end

        def instance_row(number, instance)
          [
            format('%02d:', number),
            Rainbow(instance.id).red,
            Rainbow(Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_name_tag))).green,
            Rainbow(instance.instance_type).cyan,
            Rainbow(Capistrano::Aws::EC2.contact_point(instance)).blue,
            Rainbow(instance.placement.availability_zone).magenta,
            Rainbow(Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_roles_tag))).yellow,
            Rainbow(Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_stage_tag))).yellow
          ]
        end
      end
    end
  end
end
