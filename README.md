# Capistrano AWS [![Gem Version](https://badge.fury.io/rb/capistrano-aws.svg)](https://badge.fury.io/rb/capistrano-aws)

This gem is slightly based on [cap-ec2](https://github.com/forward3d/cap-ec2), which is not maintained for a while, becoming outdated.

The purpose of this gem is to provide a flexible and simple integration to AWS EC2, exposing the aws-sdk connection in order to allow any customization.

## Requirements

* Capistrano 3

## Installation

Add to your `Gemfile` and run `bundler`:
```ruby
gem 'capistrano-aws'
```

Or install the gem system-wide:
```bash
gem install capistrano-aws
```

In your `Capfile`:
```ruby
require 'capistrano/aws'
```

## Configuration

```ruby
# AWS regions to use.
set :aws_ec2_regions, ['us-east-1']

# Application name to match application tag.
set :aws_ec2_application, (proc { fetch(:application) })

# Stage to match stage tag.
set :aws_ec2_stage, (proc { fetch(:stage) })

# Tag to be used for Capistrano stage.
set :aws_ec2_stage_tag, 'Stage'

# Tag to be used to match the application.
set :aws_ec2_application_tag, 'Application'

# Tag to be used for Capistrano roles of the server (the tag value can be a comma separated list).
set :aws_ec2_roles_tag, 'Roles'

# Extra filters to be used to retrieve the instances. See the README.md for more information.
set :aws_ec2_extra_filters, []

# Tag to be used as the instance name in the instances table (aws:ec2:instances task).
set :aws_ec2_name_tag, 'Name'

# How to contact the instance (:public_ip, :public_dns, :private_ip, :private_dns, :id, :ipv_6_address).
set :aws_ec2_contact_point, :public_ip
```

The AWS credentials are loaded from your system. Check https://github.com/aws/aws-sdk-ruby#configuration for more information.

## Usage

The instances must be registered in each stage. In your `config/deploy/<stage_name>.rb`, add the following line:

*This must be placed after you have configured your AWS settings*
```ruby
aws_ec2_register
```

It will use the instance tags to call the `server` function in capistrano. You can pass a hash as an argument, and it will be merged into the function call:

```ruby
aws_ec2_register user: 'hello', port: 2222
```

### Custom EC2 Filters

If you need to identify the instances based on more information, you can specify extra filters to be used in the `filters` option in the [Aws::EC2::Resource.instances](https://docs.aws.amazon.com/sdkforruby/api/Aws/EC2/Resource.html#instances-instance_method) call.

Imagine you have some split test servers for your production environment, so you can use another tag for specifying the variation of some servers:

| Name      | Application | Environment | Roles  | SplitTestVariation |
|-----------|-------------|-------------|--------|--------------------|
| foo-app01 | foo-app     | production  | app,db | 0                  |
| foo-app02 | foo-app     | production  | app    | 0                  |
| foo-app03 | foo-app     | production  | app    | 1                  |
| foo-app04 | foo-app     | production  | app    | 1                  |

In your environment files:

```ruby
# production.rb

set :aws_ec2_extra_filters, [
  {
    name: "tag:SplitTestVariation",
    values: ["0"],
  },
]
```

```ruby
# production-b.rb

set :aws_ec2_stage, "production" # Optional. Use if you have the same environment for the B servers.
set :aws_ec2_extra_filters, [
  {
    name: "tag:SplitTestVariation",
    values: ["1"],
  },
]
```

The `:aws_ec2_stage` variable is needed in order to override the default value of the stage fielter(`:stage`). If you really have a different environment for your `B` servers, you can just use the name of the environment as the file name and remove this line.

## Utility tasks

### aws:ec2:instances

List all the instances found for with the current configuration.

```bash
cap production aws:ec2:instances
```

## Contributing

Open an issue or make a PR, feel free to contribute!
