### Template 1 - Deploy ALL with Autoscaling

![architecture-1](https://s3.amazonaws.com/personal-website-assets104410-dev/projects/template-1-autoscaling.png)

This template package provides a simple 2 tier architecture that deployes a Network stack, Compute stack and a Security stack. This is the layout:

Network Stack:
- VPC
- VPC Flow Logs
- 4 HA subnets
  - Public (a & b)
  - Web (a & b)
  - App (a & b)
  - DB (a & b)
- RT
  - Routes (pubs and pri)
  - RT Associations
- IGW

Security Resources:
- SG External ALB
- SG Web
- SG Internal ALB
- SG App
- SG DB

Compute Stack:
- ALB External 
  - target groups (web autoscaling servers)
  - target group attachment: HTTP:80
  - listeners: HTTP:80
- ALB Internal 
  - target groups (app autoscaling servers)
  - target group attachment: HTTP:80
  - listeners: HTTP:80
- 1 NAT host server
- 2 Autoscaling group servers
  - HTTP Autoscaling server (with build script)
  - PHP Autoscaling server (with build script)

Storage:
- 2 S3 buckets
  - 1 for External ALB logs
  - 1 for Internal ALB logs

NOTE: everything is going to be deployed at once!