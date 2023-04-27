variable "project" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region name"
}

variable "zone" {
  type        = string
  description = "Zone name"
}

variable "names" {
  type        = list(string)
  description = "Name of services to create"
}

variable services {
  type        = list
  default     = [
    "iam.googleapis.com",
    "compute.googleapis.com"
  ]
}