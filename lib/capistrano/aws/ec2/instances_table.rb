require 'terminal-table'
require 'colorize'

module Capistrano
  module Aws
    module EC2
      # Generates instances table.
      class InstancesTable
        def initialize(instances)
          @instances = instances
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
            'Num'.colorize(mode: :bold),
            'ID'.colorize(mode: :bold),
            'Name'.colorize(mode: :bold),
            'Type'.colorize(mode: :bold),
            'Contact Point'.colorize(mode: :bold),
            'Availability Zone'.colorize(mode: :bold),
            'Roles'.colorize(mode: :bold),
            'Stages'.colorize(mode: :bold)
          ]
        end

        def instance_row(number, instance)
          [
            format('%02d:', number),
            instance.id.colorize(:red),
            Capistrano::Aws::EC2.parse_tag(instance, 'Name').colorize(:green),
            instance.instance_type.colorize(:cyan),
            Capistrano::Aws::EC2.contact_point(instance).colorize(:blue),
            instance.placement.availability_zone.colorize(:magenta),
            Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_roles_tag)).colorize(:yellow),
            Capistrano::Aws::EC2.parse_tag(instance, fetch(:aws_ec2_stage_tag)).colorize(:yellow)
          ]
        end
      end
    end
  end
end
