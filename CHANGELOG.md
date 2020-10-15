# Changelog

## v0.21.0 - 2020-10-15

- Change `lambda` module: 
    - use predefined AWS IAM policy for Cloudwatch logging permissions
    - create Cloudwatch Log Group to be able to set it's retention policy
    - add function name to outputs
- Change `cognito` module:
    - add lambda permission resource to update the custom message trigger lamda resource policy
    - add clients ids and user pool id outputs
- Change `elb` module:
    - Add option to configure healthcheck path on each Target Group using `target_groups.healthcheck_path`
    - update output name `target_groups_arns`

## v0.20.0 - 2020-10-15

- Change `ecr` module to create a single repository instead of multiple, it takes a single repository name now instead of a list

## v0.19.0 - 2020-10-15

- Update `acm` module to work without Cloudfront certificates also

## v0.18.0 - 2020-10-14

- Remove ECS cluster creation from `ecs` module
- Add option to create Security Group ingress rule based with soruce Security Group Id or CIDR blocks
- Create ECS Service log group to set be able to set log group's retention policy  

## v0.17.0 - 2020-10-14

- Add module for creating and ECS cluster

## v0.16.0 - 2020-09-24

- Remove pre-0.13 experimental variable_validation from all modules. It's not experimental anymore in terraform 0.13 

## v0.15.0 - 2020-08-09

- Add AWS SES, Lambda and Cognito modules
- Add Route53 module feature to create non-alias records also 

## v0.14.0 - 2020-07-18

Add db subnet group to VPC module

## v0.13.0 - 2020-07-18

Add ECR module

## v0.12.0 - 2020-07-18

Add ELB module

## v0.11.0 - 2020-07-18

Add zone id as output to route53-zone module

## v0.10.0 - 2020-07-18

Add hosted zone name output to route53-zone module

## v0.9.0 - 2020-07-18

Move route53 zone to separate route53 module

## v0.8.0 - 2020-07-18

Change route53-zone module to output only zone name and name servers

## v0.7.0 - 2020-07-12

Change IAM module to use `aws_iam_policy_document` instead of `templatefile` with files.
Add feature to configure IAM roles, trusted entities can only be AWS accounts for now.

## v0.6.0 - 2020-07-12

Added IAM stateless module. 

Accepts `list`s of groups, users and policies that can be used to create these resources and connect them by names references.

e.g. `var.users.*.group_names` determines to wich groups the user will be attached to, but will not create the group. 
That must be done with `var.groups`.

## v0.5.0 - 2020-07-12

Changed AWS Organizations module to be stateless, removed hardcoded account and organizational units logic. 

Module accepts a `set` of OUs names and a `list` of accounts objects as variables now. 
Links an account to OU's based on `var.accounts.*.organizational_unit`.  

## v0.4.0 - 2020-07-06

Added AWS Route53 module, can be used to create Route53 zones and records. Supports Route53 alias records as well. 

## v0.3.0 - 2020-07-06

Added AWS ACM module, can be used to create and validate SSL certificates. It does the validation through DNS record.
 