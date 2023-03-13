
module "gke_tls_certificates" {
  source = "../../../terraform-templates/commons/tls-certificates"

  cluster_instance_name = local.instance_name
  cluster_environments  = local.environments
  cluster_dns_name      = local.dns_name
  cluster_issuer_email  = var.cluster_issuer_email
  cluster_issuer_server = var.cluster_issuer_server

}

