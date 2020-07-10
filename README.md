# Terraform Infrastructure as Code
![aws-devops](https://s3.amazonaws.com/personal-website-assets/Projects/terraform-aws.png)

## Run resources:

```
1. go to the template
2. run terraform init
3. terraform workspace new $YOUR_WORKSPACE
4. terraform apply
    yes to the confirm message if 
```

## Terraform Backend

This repo is using terraform backend in its core in order to record infrastructure code changes. Hence you may want to deploy and configure an S3 bucket and a DynamoDB table in order to populate the information in the backend.tf files inside of the template and feature directories.

Here is a step by step guide on how to do this: https://medium.com/@jessgreb01/how-to-terraform-locking-state-in-s3-2dc9a5665cb6