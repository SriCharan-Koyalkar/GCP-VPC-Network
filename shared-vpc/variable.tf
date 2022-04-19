#######################
# Define all the variables we'll need
#######################

variable "host_project_name" {
  description = "The shared VPC host project name"
  default = "my-host-project-001"
}

variable "service_projects" {
  description = "map of service project names to project IDs"
  type        = map(string)
  //default = "my-service-project-001"
}

variable "service_networks" {
  description = "map of service project names to associated subnetworks"
  type        = map(string)
  //default = "my-service-network-001"
}
