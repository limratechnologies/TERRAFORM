#Output the IP Address of the Container
output "IPAddress" {
  value       = docker_container.container_id.ip_address
  description = "The IP for the container."
}

output "container_name" {
  value       = docker_container.container_id.name
  description = "The name of the container."
}

