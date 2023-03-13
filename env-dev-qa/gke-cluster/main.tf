locals {
  instance_name = "${var.instance_name}-${join("", var.environments)}"
}

module "gke_cluster" {
  source = "../../../terraform-templates/gcp/gke-cluster/private-gke-cluster"
  #source = "git::https://github.com/israel-anaya/terraform-templates.git//template-gke-cluster"


  instance_name      = local.instance_name
  project_id         = var.project_id
  region             = var.region
  main_zone          = var.main_zone
  node_zones         = var.node_zones
  machine_type       = var.machine_type
  node_count         = var.node_count
  enable_autopilot   = var.enable_autopilot

}