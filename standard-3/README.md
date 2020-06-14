this will include a database

### Standard 3

![architecture-1](https://personal-website-assets.s3.amazonaws.com/Projects/architectures.png)

This standard package provides a simple 2 tier architecture that deployes a Network stack and a Compute stack. The former is going deploy a VPC, Subnets and other related networking resources to build the base for the Compute stack. The Compute stack deployes a bastion host, web server, a load balancer with listeners and target groups. This is the layout:

Network Stack:
- VPC
- 4 Subnets
  - Public
  - Web
  - App
  - DB
- RT
  - Routes (pubs and pri)
  - RT Associations
- IGW

Security Resources:
- SG ALB
- SG Web
- SG App
- SG DB

Compute Stack:
- ALB
  - target groups
  - target group attachment
  - listeners
- 2 Servers
  - NAT bastion host
  - web server (with build script)

Database Stack:
- RDS
  - subnet group

Storage:
- S3 bucket for load balancer logs

NOTE: everything is going to be deployed at once!