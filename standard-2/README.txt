This standard package provides 2 stacks for a simple architecture
These stacks will be deployed together in the same directory. It is
important to notice that these stacks will be composed by two modules:

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