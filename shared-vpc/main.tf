#######################
# enable necessary APIs for shared VPC
# note that google_project_service is additive and not authoritative, unlike google_project_services 
# (see https://www.terraform.io/docs/providers/google/r/google_project_services.html on why we aren't using it)
#######################

resource "google_project_service" "host-compute" {
  project = var.host_project_name
  service = "compute.googleapis.com"
}

resource "google_project_service" "host-container" {
  project = var.host_project_name
  service = "container.googleapis.com"
}

#######################
# enable shared VPC for host project, attach service projects to host project
#######################
resource "google_compute_shared_vpc_host_project" "host-shared-vpc" {
  project = var.host_project_name
}

resource "google_compute_shared_vpc_service_project" "service" {
  count           = length(var.service_projects)
  host_project    = var.host_project_name
  service_project = element(keys(var.service_projects), count.index)

  // Shared VPC needs to be enabled on host project fist
  depends_on = [google_compute_shared_vpc_host_project.host-shared-vpc]
}

#######################
# set necessary network permissions on host network for service accounts from service projects, so that they can create resources within their given subnetworks of the host network
#######################
resource "google_compute_subnetwork_iam_member" "cloudservices" {
  count      = length(var.service_projects)
  subnetwork = var.service_networks[element(keys(var.service_networks), count.index)]
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:${var.service_projects[element(keys(var.service_projects), count.index)]}@cloudservices.gserviceaccount.com"
}

resource "google_compute_subnetwork_iam_member" "container-engine-robot" {
  count      = length(var.service_projects)
  subnetwork = var.service_networks[element(keys(var.service_networks), count.index)]
  role       = "roles/compute.networkUser"
  member     = "serviceAccount:service-${var.service_projects[element(keys(var.service_projects), count.index)]}@container-engine-robot.iam.gserviceaccount.com"
}

#######################
# enable GKE API for service projects
#######################
resource "google_project_service" "service-container" {
  count   = length(var.service_projects)
  project = element(keys(var.service_projects), count.index)
  service = "container.googleapis.com"
}

resource "google_project_iam_member" "gke-service-account" {
  count   = length(var.service_projects)
  project = var.host_project_name
  member  = "serviceAccount:service-${var.service_projects[element(keys(var.service_projects), count.index)]}@container-engine-robot.iam.gserviceaccount.com"
  role    = "roles/container.hostServiceAgentUser"
}