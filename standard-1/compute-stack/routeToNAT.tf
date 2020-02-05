module "publicRoutes" {
  source       = "../../modules/route/"
  #need to have these two values
  #route table should be gotten from the outputs of previous folder
  routeTableId = "${var.routeTableId}"
  destination  = "${var.destinationRoute}"
  instanceId   = "${element(module.nat-host.ec2-id, 1)}"
}
