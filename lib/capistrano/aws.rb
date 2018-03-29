require 'capistrano/aws/ec2/ec2'
require 'capistrano/dsl/aws'

extend Capistrano::DSL::Aws

SSHKit::Backend::Netssh.send(:include, Capistrano::DSL::Aws)

load File.expand_path('../tasks/ec2.rake', __FILE__)
load File.expand_path("../tasks/defaults.rake", __FILE__)
