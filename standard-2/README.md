This standard package provides a simple 2 tier architecture that deployes a Network stack and a Compute stack. The former is going deploy a VPC, Subnets and other related networking resources to build the base for the Compute stack. The Compute stack deployes a bastion host, web server, a load balancer with listeners and target groups. This is the layout:

Network Stack:
-- VPC
-- 3 Subnets
---- Web
---- App
---- DB
-- RT
---- Routes (pubs and pri)
---- RT Associations
-- IGW

Security Resources:
-- SG ALB
-- SG Web
-- SG App
-- SG DB

Compute Stack:
-- ALB
--- target groups
--- target group attachment
--- listeners
-- 2 Servers
--- bastion host
--- web server (with build script)

NOTE: everything is going to be deployed at once!