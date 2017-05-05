require 'capistrano/aws/ec2/ec2'
require 'capistrano/dsl/aws'
extend Capistrano::DSL::Aws

load File.expand_path('../tasks/ec2.rake', __FILE__)

namespace :load do
  task :defaults do
    load 'capistrano/aws/defaults.rb'
  end
end
