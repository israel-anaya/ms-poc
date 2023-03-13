output "endpoints" {
  description = "Map of instance name -> internal runtime endpoint IP address."
  value       = module.apigee-x-core.endpoints
}

output "ports" {
  description = "Port number of the internal endpoint of the Apigee instance."
  value       = module.apigee-x-core.ports
}
