Manual
Shell script
Ansible -> more preferred, config as code

DEV, QA, PRE-PROD, UAT, Prod
code is working in DEV but not working in prod
inconsistent configuration across env

## Infrastructure
Infrastructure as a code -> Iaas/Iac
Terraform -> Iaac

ENV setup
advantages
1. version control
since terraform is a code, it should be kept in version control, so that we can maintain the history and we can revert to previous version if something goes wrong
2. consistent infrastructure
same terraform code you run against multiple env, so all env is exactly same
3. CRUD -> create read update delete
4. inventory management
by seeing terraform, you can say what are the services and resources you are using for a particular project(doing n checking it manually through console its time consuming)
5. cost optimization
when you need you create infra, when not required delete the infra
6. dependency management
ec2 -> security group
first create security group and then create ec2 -> manual
ec2 -> security group -> terraform
7. modules - reusing code

DRY - Don't repeat yourself
common -> use wherever reuired, central

8. terraform is popular declarative scripting for infrastructure automation
declarative: easy syntax, no need of sequence execution, we will get it whatever we write if we follow syntax

IDE -> VS cde
terraform.exe keep it in a folder and set the path
AWS CLI V2

Authentication
create IAM user with admin access
generate access key and secret key
aws configure, give us-east-1

hybride Iaac
------------
providers
AWS
GCP
Azure
github

our website
------------
develop providers
terraform can create resources into our website

roboshop
-----------
create user or group
you can develop roboshop terraform provider and you can use terraform to create users

HCL - Hashicorp configuration language

variables
conditions
loops
functions

resource "what-resource" "name-your-resource" {
    arguments/options
}

what-resource - you can get it from terraform documentation


AMI - mandatory
SG - optional, if you won't provide SG default one will be selected

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

create of resources
-------------------
1. provider -> you need to tell terraform which provider
2. ec2.tf

terraform init -> this will initalize terraform
terraform plan -> terraform will tell us what are the resources it is going to create
terraform apply -> it will create the resources
terraform destroy -> it will destroy resources
