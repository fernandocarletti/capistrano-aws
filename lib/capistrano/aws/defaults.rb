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
