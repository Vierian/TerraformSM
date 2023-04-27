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

variable "user" {
  type        = string
  description = "User name"
}

variable "names" {
  type        = list(string)
  description = "Name of services to create"
}

variable "pubsub" {
  type = map(object({
    name   = string,
    sender = bool
  }))
  description = "pubsub confiuration"
}

variable "subnets" {
  type        = list(map(string))
  description = "The list of subnets being created"
}