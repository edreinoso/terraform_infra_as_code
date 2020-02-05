This standard package provides 2 stacks for a simple architecture
These stacks need to deployed separately from each other since
there is no communication in between then.

Network Stack:
-- VPC
-- 3 Subnets
---- Web
---- App
---- DB
-- RT
---- Routes
---- RT Associations
-- IGW
-- SG
--- SG ALB
--- SG Web
--- SG App
--- SG DB


Compute Stack:
-- alb
--- target groups
--- target group attachment
--- listeners
-- bastion host
-- web server
-- application server