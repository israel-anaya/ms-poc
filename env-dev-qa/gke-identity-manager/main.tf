
module "identity_manager" {
  source = "../../../terraform-templates/commons/keycloak"

  imagetag              = var.imagetag
  cluster_instance_name = local.instance_name
  cluster_environments  = local.environments
  cluster_dns_name      = local.dns_name

}
