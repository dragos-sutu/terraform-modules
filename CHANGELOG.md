# Changelog

## v0.5.0 2020-07-12

Changed AWS Organizations module to be stateless, removed hardcoded account and organizational units logic. 

Module accepts a `set` of OUs names and a `list` of accounts objects as variables now. 
Links an account to OU's based on `var.accounts.*.organizational_unit`.  

## v0.4.0 2020-07-06

Added AWS Route53 module, can be used to create Route53 zones and records. Supports Route53 alias records as well. 

## v0.3.0 2020-07-06

Added AWS ACM module, can be used to create and validate SSL certificates. It does the validation through DNS record.
 