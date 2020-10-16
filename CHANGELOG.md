# Changelog

## v0.22.0 - 2020-10-16

- `ecr`:
    - added Lifecycle Policy based on image counter, images older than `lifecycle_policy_image_count` number of days will expire, defaults to 20
- `ecs`:
    - fixed syntax error with conditionals in Security Groups
- `elb`:
    - added variable to configure ALB deletion protection, default is enabled 

## v0.21.0 - 2020-10-15

- `lambda`: 
    - added predefined AWS IAM policy for Cloudwatch logging permissions on lamda IAM execution role
    - added Cloudwatch Log Group creation to be able to set its retention policy
    - added function name to outputs
- `cognito`:
    - added lambda permission resource to update the custom message trigger lamda resource policy
    - added clients ids and user pool id outputs
- `elb`:
    - added option to configure healthcheck path on each Target Group using `target_groups.healthcheck_path`
    - updated Target Groups ARNs output name

## v0.20.0 - 2020-10-15

- `ecr` creates a single repository instead of multiple, it takes a single repository name now instead of a list

## v0.19.0 - 2020-10-15

- `acm` works without Cloudfront certificates also now

## v0.18.0 - 2020-10-14

- `ecs`: 
    - removed ECS cluster creation from module
    - added option to create Security Group ingress rule based on source Security Group Id or CIDR blocks
    - creates Log Group for ECS Service to set be able to set log group's retention policy  

## v0.17.0 - 2020-10-14

- added module for creating and ECS cluster

## v0.16.0 - 2020-09-24

- removed pre-0.13 experimental variable_validation from all modules. It's not experimental anymore in terraform 0.13 

## v0.15.0 - 2020-08-09

- added AWS SES, Lambda and Cognito modules
- added Route53 module feature to create non-alias records also 

## v0.14.0 - 2020-07-18

- added db subnet group to VPC module

## v0.13.0 - 2020-07-18

- added ECR module

## v0.12.0 - 2020-07-18

- added ELB module

## v0.11.0 - 2020-07-18

- added zone id as output to route53-zone module

## v0.10.0 - 2020-07-18

- added hosted zone name output to route53-zone module

## v0.9.0 - 2020-07-18

- moved route53 zone to separate route53 module

## v0.8.0 - 2020-07-18

- changed `route53-zone` to output only zone name and name servers

## v0.7.0 - 2020-07-12

- `iam`:
    - uses `aws_iam_policy_document` instead of `templatefile` with files
    - added feature to configure IAM roles, trusted entities can only be AWS accounts for now

## v0.6.0 - 2020-07-12

- added IAM stateless module. 
Accepts `list`s of groups, users and policies that can be used to create these resources and connect them by names references
e.g. `var.users.*.group_names` determines to wich groups the user will be attached to, but will not create the group 
That must be done with `var.groups`

## v0.5.0 - 2020-07-12

- changed `organizations` module to be stateless, removed hardcoded account and organizational units logic 
Module accepts a `set` of OUs names and a `list` of accounts objects as variables now. 
Links an account to OU's based on `var.accounts.*.organizational_unit`.  

## v0.4.0 - 2020-07-06

- added AWS Route53 module, can be used to create Route53 zones and records. Supports Route53 alias records as well 

## v0.3.0 - 2020-07-06

- added AWS ACM module, can be used to create and validate SSL certificates. It does the validation through DNS record
