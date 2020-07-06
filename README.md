# Terraform modules

This repo together with [terraform-state](https://github.com/dragos-sutu/terraform-state) represent a way to achieve maintainable, immutable Terraform code.

It contains terraform modules that can be used for provision infrastructure in multiple accounts / environments.

Some of the modules are stateless others are tailored to specific setups.

## How is this repo organized ?

```
cloud-provider
 └ module
 └ ...
another-cloud-vendor
 └ module
 └ ...
```
