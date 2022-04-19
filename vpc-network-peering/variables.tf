# variables.tf defines inputs for the module

variable "project" {
  description = "Project name"
  default = "spatial-lock-338613"
}

variable "peered_project" {
  description = "Peered project name"
  default = "myproject112345"
}

variable "network_name" {
  description = "Name of network"
  default = "network-001"
}

variable "peered_network_name" {
  description = "Name of peered network"
  default = "network-002"
}

variable "network_link" {
  description = "Self link of network"
  default = "https://www.googleapis.com/compute/v1/projects/spatial-lock-338613/global/networks/network-001"
  //default = ""
}

variable "peered_network_link" {
  description = "Self link of peered network"
  default = "https://www.googleapis.com/compute/v1/projects/myproject112345/global/networks/network-002"
  //default = ""
}

variable "network_route_mode" {
  description = "Route exchange mode of network"
  default     = "both" # valid values: both, import, export
}

variable "peered_network_route_mode" {
  description = "Route exchange mode of peered network"
  default     = "both" # valid values: both, import, export
}

variable "outbound_peering_name" {
  description = "Name of the outbound peering (local network to peered network)"
  default = "outbound-001"
}

variable "inbound_peering_name" {
  description = "Name of the inbound peering (peered network to local network)"
  default = "outbound-002"
}
