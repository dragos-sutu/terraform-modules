# Terraform modules

This repo together with [terraform-state](https://github.com/dragos-sutu/terraform-state) represent a way to achieve maintainable, immutable Terraform code.

It holds (mostly) stateless terraform modules to be reused for deploying infrastructure in multiple accounts / environments.

## How is this repo organized ?

```
cloud-provider
 └ module
 └ ...
another-cloud-vendor
 └ module
 └ ...
```
