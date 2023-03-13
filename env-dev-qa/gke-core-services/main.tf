data "google_dns_managed_zone" "env_zone" {
  name    = var.dns_zone_name
  project = local.project_id
}

# External IP for Main LoadBalancer
resource "google_compute_address" "ingress_ip" {
  name    = "${local.cluster_name}-ingress-ip"
  project = local.project_id
  region  = local.region
}

resource "google_dns_record_set" "ingress" {
  name = "*.${local.instance_name}.${local.dns_name}."
  project = local.project_id
  type = "A"
  ttl  = 300

  managed_zone = data.google_dns_managed_zone.env_zone.name

  rrdatas = [google_compute_address.ingress_ip.address]
}

module "gke_core_services" {
  source = "../../../terraform-templates/commons/core-services"

  cluster_instance_name        = local.instance_name
  cluster_environments         = local.environments
  cluster_ingress_ip           = google_compute_address.ingress_ip.address

  container_registry_server   = var.container_registry_server
  container_registry_username = var.container_registry_username
  container_registry_password = var.container_registry_password

  gitlab_agent_imagetag   = var.gitlab_agent_imagetag
  gitlab_agent_token      = var.gitlab_agent_token
  gitlab_agent_kasAddress = var.gitlab_agent_kasAddress

  cert_manager_imagetag = var.cert_manager_imagetag
  
  depends_on = [
    google_compute_address.ingress_ip,
    google_dns_record_set.ingress
  ]
}

