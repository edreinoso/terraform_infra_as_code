### Template 1 - Deploy ALL

![architecture-1](https://s3.amazonaws.com/personal-website-assets104410-dev/projects/template-1-autoscaling.png)

This template package provides a simple 2 tier architecture that deployes a Network stack, Compute stack and a Security stack. This is the layout:

Network Stack:
- VPC
- 3 Subnets
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
  - bastion host
  - HTTP server (with build script)

Storage:
- S3 bucket for load balancer logs

NOTE: everything is going to be deployed at once!