output "cluster_instance_name" {
  value       = var.instance_name
  description = "Cluster instance name"
}

output "cluster_dns_name" {
  value       = var.dns_name
  description = "DNS cluster name"
}

output "cluster_environments" {
  value       = var.environments
  description = "List of Environment Names."
}

output "cluster_project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "cluster_region" {
  value       = var.region
  description = "GCloud Region"
}

output "cluster_main_zone" {
  value       = var.main_zone
  description = "The zone primary to use"
}

output "cluster_network_id" {
  value       = module.gke_cluster.cluster_network_id
  description = "Network ID"
}

output "kubernetes_cluster_name" {
  value       = module.gke_cluster.kubernetes_cluster_name
  description = "GKE Cluster Name"
}

output "kubernetes_cluster_host" {
  value       = module.gke_cluster.kubernetes_cluster_host
  description = "GKE Cluster Host"
}

output "kubectl_alias_command" {
  description = "Command that creates an alias for kubectl using Bastion as proxy. Bastion ssh tunnel must be running."
  value       = "alias kube='${module.gke_cluster.kubectl_alias_command}'"
}

output "bastion_open_tunnel_command" {
  description = "Command that opens an SSH tunnel to the Bastion instance."
  value       = module.gke_cluster.bastion_open_tunnel_command
}
