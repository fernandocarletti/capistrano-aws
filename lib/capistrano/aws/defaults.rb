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

# How to contact the instance (:public_ip, :public_dns, :private_ip).
set :aws_ec2_contact_point, :public_ip
