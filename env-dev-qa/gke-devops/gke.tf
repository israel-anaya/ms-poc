data "terraform_remote_state" "gke" {
  backend = "local"

  config = {
    path = "../gke-cluster/terraform.tfstate"
  }
}

locals {
  cluster_name  = data.terraform_remote_state.gke.outputs.kubernetes_cluster_name
  instance_name = data.terraform_remote_state.gke.outputs.cluster_instance_name
  dns_name      = data.terraform_remote_state.gke.outputs.cluster_dns_name
  environments  = data.terraform_remote_state.gke.outputs.cluster_environments
  project_id    = data.terraform_remote_state.gke.outputs.cluster_project_id
  region        = data.terraform_remote_state.gke.outputs.cluster_region
}

data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  project  = local.project_id
  name     = local.cluster_name
  location = local.region
}

provider "helm" {
  kubernetes {
    #host = "https://${data.terraform_remote_state.gke.outputs.kubernetes_cluster_host}"
    host = "http://localhost:9090" # Use proxy with private GKE

    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  }
}

provider "kubernetes" {
  #host = "https://${data.terraform_remote_state.gke.outputs.kubernetes_cluster_host}"
  host = "http://localhost:9090" # Use proxy with private GKE

  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}
