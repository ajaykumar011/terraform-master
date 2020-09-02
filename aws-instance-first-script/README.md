# aws-instance-first-script

![](https://github.com/easyawslearn/Terraform-Tutorial/workflows/terraform-tutorials-ci/badge.svg)

A Terraform module for creating AWS EC2 instance.

## Usage

```hcl
module "ec2_instance" {
  source     = "git::https://github.com/easyawslearn/Terraform-Tutorial.git//aws-instance-first-script"

  region    = "us-west-2"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | AWS region | string | us-east-1 | yes |



# Commands are below


On CLI (without Jenkins)           

### Git the repository and enter the directory and run the below commands. you don't need to specify AWS credentials if the AWS configure is already done. or you can simply export the Access key and Secret key to environment variable using export command in linux.

terraform init -input=false
terraform workspace new env1                    

### env1 is the name of environment, after this command you will see the env1 folder created under terraform.tfstate.d
terraform workspace list

terraform workspace select env1
terraform plan -out tfplan
terraform show -no-color tfplan > tfplan.txt
terraform apply tfplan


OUTPUT:
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate


If you find any warning of Interpolation you can use like below: 
Warning: Interpolation-only expressions are deprecated


