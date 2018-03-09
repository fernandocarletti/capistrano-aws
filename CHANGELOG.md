2018-03-08 - 1.1.0 - Custom filters

* Support extra filters for retrieving EC2 instances.
* Allow customization of the stage filter value.
* Improved description of the :aws_ec2_roles_tag variable.
* Removed Gemfile.lock.
* Order instances by name in the instances table.

2017-05-05 - 1.0.1 - Improved instances access

* Turn instances result into a hash, being able to access the instance by its id.
* Fixed aws_ec2 not being exposed to SSHKit.

2017-05-05 - 1.0.0 - Initial Release

* Add servers from multiple regions.
* Access EC2 client with the DSL in your custom tasks.
