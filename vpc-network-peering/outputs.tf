# output.tf defines outputs for the module.

output "peering_connection" {
  description = "Name of the peering connection"
  value       = google_compute_network_peering.primary_network
}
