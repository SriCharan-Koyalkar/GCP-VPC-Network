##############################################################################
# Variables File
#
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "project" {
  description = "ID of your GCP project. Make sure you set this up before running this terraform code.  REQUIRED."
}

variable "prefix" {
  description = "This prefix will be included in the name of some resources. You can use your own name or any other short string here."
}

variable "region" {
  description = "The region where the resources are created."
}

variable "zone" {
  description = "The zone where the resources are created."
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
}

variable "machine_type" {
  description = "Specifies the GCP instance type."
}
