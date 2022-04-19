provider "google" {
  version = "~> 3.67.0"
  project = var.project
  zone    = var.zone
  region  = var.region
  credentials = file("credentials.json")
}