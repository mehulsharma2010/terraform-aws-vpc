AWS Network Skeleton Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates network skeleton on AWS.


Terraform versions
------------------
Terraform 0.14.9

Resources
------
| Name | Type |
|------|------|
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | Resource |
| [aws_flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | Resource |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | Resource |
| [aws_route53_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | Resource |

Usage
------

```hcl
provider "aws" {
  region                  = "ap-south-1"
}

module "network_skeleton" {
  source                                               = "../"
  vpc_name                                             = var.vpc_name
  cidr_block                                           = "10.0.0.0/16"
  enable_dns_hostnames                                 = true
  enable_vpc_logs                                      = false
  pvt_zone_name                                        = "test.non-prod.net"
  public_subnets_cidr                                  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets_cidr                                 = ["10.0.16.0/20", "10.0.32.0/20", "10.0.48.0/24", "10.0.49.0/24", "10.0.50.0/24", "10.0.51.0/24"]
  pvt_rt_ame                                           = var.pvt_rt_ame
  pvt_subnet_name                                      = var.pvt_subnet_name
  pub_subnet_name                                      = var.pub_subnet_name
  pub_rt_name                                          = var.pub_rt_name
  igw_name                                             = var.igw_name
  nat_name                                             = var.nat_name
  avaialability_zones                                  = ["ap-south-1a", "ap-south-1b"]
  logs_bucket                                          = ""
  logs_bucket_arn                                      = ""
  tags                                                 = {"Environment" = "non-prod", "Owner" = "devops"}
  subnet_tags                                          = {"Subnet" = "private", "App" = "EKS"}
  public_web_sg_name                                   = "ns-web-sg"
  alb_certificate_arn                                  = ""
  alb_name                                             = var.alb_name
  enable_igw_publicRouteTable_PublicSubnets_resource   = true
  enable_nat_privateRouteTable_PrivateSubnets_resource = true
  enable_public_web_security_group_resource            = false
  enable_pub_alb_resource                              = false
  enable_aws_route53_zone_resource                     = false
}
```
**Note: Like all the enable resource variables (last 5) are set to false in module, It will only create VPC.**

**For more information, you can check example folder.**

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by subnet_tags variables as defined above.

Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | The sting name append in tags | `string` | `"opstree"` | yes |
| cidr_block | The CIDR block for the VPC. Default value is a valid CIDR  | `string` | `"10.0.0.0/16"` | no |
| instance_tenancy | A tenancy option for instances launched into the VPC | `string` | `"default"` | no |
| enable_dns_support | A dns support for instances launched into the VPC | `boolean` | `"true"` | no |
| enable_dns_hostnames | A dns hostname for instances launched into the VPC | `boolean` | `"false"` | no |
| enable_classiclink |A dns classiclink for instances launched into the VPC | `boolean` | `"false"` | no |
| enable_igw_publicRouteTable_PublicSubnets_resource | This variable is used to create IGW, Public Route Table and Public Subnets | `boolean` | `"True"` | no |
| enable_nat_privateRouteTable_PrivateSubnets_resource |This variable is used to create NAT, Private Route Table and Private Subnets | `boolean` | `"True"` | no |
| enable_public_web_security_group_resource | This variable is to create Web Security Group | `boolean` | `"True"` | no |
| enable_pub_alb_resource | This variable is to create ALB | `boolean` | `"True"` | no |
| enable_aws_route53_zone_resource | This variable is to create Route 53 Zone | `boolean` | `"True"` | no |


Output
------
| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| pub_route_table_id | Public route table ID's |
| pvt_route_table_id | Private Route table ID's |
| pvt_hosted_zone_id | Private Hosted zone ID's |
| pvt_subnet_ids | Private Subnet table ID's |
| public_subnet_ids | Public Subnet table ID's |
| web_sg_id | Public Security Group table ID's |
| dns_name | DNS of ALB |
| aws_lb_arn | arn of ALB |
| alb_listener_arn | ARN of alb listener |
| alb_listener1_arn | ARN of alb listener-1 |
| route53_name | Domain Name of Route 53 private hosted zone |


## Related Projects

* [route-table](https://registry.terraform.io/modules/OT-CLOUD-KIT/route-table/aws/latest?tab=inputs)
* [subnet](https://registry.terraform.io/modules/OT-CLOUD-KIT/subnet/aws/latest) 
* [nat-gateway](https://registry.terraform.io/modules/OT-CLOUD-KIT/nat-gateway/aws/latest) 
* [security-groups](https://registry.terraform.io/modules/OT-CLOUD-KIT/security-groups/aws/latest)
* [alb](https://registry.terraform.io/modules/OT-CLOUD-KIT/alb/aws/latest)

##Additional Requirements
----
* Option to create NAT gateway for each AZ.

### Contributors

|  [![Sudipt Sharma][sudipt_avatar]][sudipt_homepage]<br/>[Sudipt Sharma][sudipt_homepage] | [![Devesh Sharma][devesh_avataar]][devesh_homepage]<br/>[Devesh Sharma][devesh_homepage] | [![Rishabh Sharma][rishabh_avatar]][rishabh_homepage]<br/>[Rishabh Sharma][rishabh_homepage]
|---|---|---|

  [sudipt_homepage]: https://github.com/iamsudipt
  [sudipt_avatar]: https://img.cloudposse.com/75x75/https://github.com/iamsudipt.png
  [devesh_homepage]: https://github.com/deveshs23
  [devesh_avataar]: https://img.cloudposse.com/75x75/https://github.com/deveshs23.png
  [rishabh_homepage]: https://www.linkedin.com/in/rishabh-sharma-b4a0b3152
  [rishabh_avatar]: https://img.cloudposse.com/75x75/https://github.com/rishabhhsharmaa.png

