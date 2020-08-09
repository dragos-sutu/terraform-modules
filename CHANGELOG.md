# Changelog

## v0.15.0 2020-08-09

- Add AWS SES, Lambda and Cognito modules
- Add Route53 module feature to create non-alias records also 

## v0.14.0 2020-07-18

Add db subnet group to VPC module

## v0.13.0 2020-07-18

Add ECR module

## v0.12.0 2020-07-18

Add ELB module

## v0.11.0 2020-07-18

Add zone id as output to route53-zone module

## v0.10.0 2020-07-18

Add hosted zone name output to route53-zone module

## v0.9.0 2020-07-18

Move route53 zone to separate route53 module

## v0.8.0 2020-07-18

Change route53-zone module to output only zone name and name servers

## v0.7.0 2020-07-12

Change IAM module to use `aws_iam_policy_document` instead of `templatefile` with files.
Add feature to configure IAM roles, trusted entities can only be AWS accounts for now.

## v0.6.0 2020-07-12

Added IAM stateless module. 

Accepts `list`s of groups, users and policies that can be used to create these resources and connect them by names references.

e.g. `var.users.*.group_names` determines to wich groups the user will be attached to, but will not create the group. 
That must be done with `var.groups`.

## v0.5.0 2020-07-12

Changed AWS Organizations module to be stateless, removed hardcoded account and organizational units logic. 

Module accepts a `set` of OUs names and a `list` of accounts objects as variables now. 
Links an account to OU's based on `var.accounts.*.organizational_unit`.  

## v0.4.0 2020-07-06

Added AWS Route53 module, can be used to create Route53 zones and records. Supports Route53 alias records as well. 

## v0.3.0 2020-07-06

Added AWS ACM module, can be used to create and validate SSL certificates. It does the validation through DNS record.
 