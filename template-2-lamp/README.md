this will include a database

### Template 2 - LAMP STACK

![architecture-1](https://s3.amazonaws.com/personal-website-assets/Projects/lamp-stack.png)

This template package provides a simple 3 tier architecture that deployes a Network stack, Compute stack, Security stack and a Database stack. This is the layout:

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
- 3 Servers
  - NAT bastion host
  - HTTP server (with build script)
  - PHP server (with build script)

Database Stack:
- RDS
  - subnet group

Storage:
- S3 bucket for load balancer logs

NOTE: everything is going to be deployed at once!