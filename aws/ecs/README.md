# ECS

## Enable Amazon ECS ARN and resource ID settings

```shell script
aws ecs put-account-setting --name containerInstanceLongArnFormat --value enabled
aws ecs put-account-setting --name serviceLongArnFormat --value enabled
aws ecs put-account-setting --name taskLongArnFormat --value enabled
```

or
- go to *Amazon ECS* *Account Settings* page in AWS console
- under *Amazon ECS ARN and resource ID settings* change *Service* and *Task* dropdowns to *Enabled*

https://console.aws.amazon.com/ecs/home?region=us-east-1#/settings

To make it the default:

```shell script
aws ecs put-account-setting-default --name containerInstanceLongArnFormat --value enabled
aws ecs put-account-setting-default --name serviceLongArnFormat --value enabled
aws ecs put-account-setting-default --name taskLongArnFormat --value enabled
```
