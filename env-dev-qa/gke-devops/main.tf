
module "devops" {
  source = "../../../terraform-templates/devops/cluster/jenkins"

  imagetag = var.imagetag
  cicd_dns_name = "jenkins.${local.instance_name}.${local.dns_name}"
  sast_dns_name = "sonarqube.${local.instance_name}.${local.dns_name}"
  repository_dns_name = "repository.${local.instance_name}.${local.dns_name}"

}
