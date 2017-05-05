Capistrano AWS
==============

This gem is slightly based on [cap-ec2](https://github.com/forward3d/cap-ec2), which is not maintained for a while, becoming outdated.

The purpose of this gem is to provide a flexible and simple integration to AWS EC2, exposing the aws-sdk connection in order to allow any customization.

# Requirements

* Capistrano 3

# Installation

Add to your `Gemfile` and run `bundler`:
```ruby
gem 'capistrano-linio'
```

Or install the gem system-wide:
```bash
gem install cap-ec2
```

In your `Capfile`:
```ruby
require 'capistrano/aws'
```

# Configuration

```ruby
# AWS regions to use.
set :aws_ec2_regions, ['us-east-1']

# Application name to match application tag.
set :aws_ec2_application, (proc { fetch(:application) })

# Tag to be used for Capistrano stage.
set :aws_ec2_stage_tag, 'Stage'

# Tag to be used to match the application.
set :aws_ec2_application_tag, 'Application'

# Tag to be used for Capistrano roles of the server (comma separated list).
set :aws_ec2_roles_tag, 'Roles'

# How to contact the instance (:public_ip, :public_dns, :private_ip).
set :aws_ec2_contact_point, :public_ip
```

The AWS credentials are loaded from your system. Check https://github.com/aws/aws-sdk-ruby#configuration for more information.

# Usage

The instances must be registered in each stage. In your `config/deploy/<stage_name>.rb`, add the following line:

```ruby
aws_ec2_register
```

It will use the instance tags to call the `server` function in capistrano. You can pass a hash as an argument, and it will be merged into the function call:

```ruby
aws_ec2_register user: 'hello', port: 2222
```

# Utility tasks

## aws:ec2:instances

List all the instances found for with the current configuration.

```bash
cap production aws:ec2:instances
```

# Contributing

Open an issue or make a PR, feel free to contribute!
