# main.tf contains the top-level resources created by this module.
#
# This module manages network peering, both networks must create a peering with
# each other for the peering to be functional.

resource "google_compute_network_peering" "primary_network" {
  name         = coalesce(var.outbound_peering_name, "${var.network_name}-to-${var.peered_network_name}")
  network      = var.network_link
  peer_network = var.peered_network_link

  import_custom_routes = local.import_primary_network
  export_custom_routes = local.export_primary_network
}

resource "google_compute_network_peering" "peered_network" {
  name         = coalesce(var.inbound_peering_name, "${var.peered_network_name}-to-${var.network_name}")
  network      = var.peered_network_link
  peer_network = var.network_link

  import_custom_routes = local.import_peered_network
  export_custom_routes = local.export_peered_network

  # Note: have to create the peering sequentially as there is a race condition
  depends_on = [google_compute_network_peering.primary_network]
}

resource "google_compute_network_peering_routes_config" "primary_network" {
  project = var.project
  network = var.network_name
  peering = google_compute_network_peering.primary_network.name

  import_custom_routes = local.import_primary_network
  export_custom_routes = local.export_primary_network
}

resource "google_compute_network_peering_routes_config" "peered_network" {
  project = var.peered_project
  network = var.peered_network_name
  peering = google_compute_network_peering.peered_network.name

  import_custom_routes = local.import_peered_network
  export_custom_routes = local.export_peered_network

  # Note: have to create the peering sequentially as there is a race condition
  depends_on = [google_compute_network_peering_routes_config.primary_network]
}

locals {
  # Whether primary network should import from and/or export to peered network
  import_primary_network = (var.network_route_mode == "both" || var.network_route_mode == "import") ? true : false
  export_primary_network = (var.network_route_mode == "both" || var.network_route_mode == "export") ? true : false

  # Whether peered network should import from and/or export to primary network
  import_peered_network = (var.peered_network_route_mode == "both" || var.peered_network_route_mode == "import") ? true : false
  export_peered_network = (var.peered_network_route_mode == "both" || var.peered_network_route_mode == "export") ? true : false
}
