variable "project" {
  type = string
  description = "Project ID"
}

variable "region" {
  type = string
  description = "Region name"
}

variable "zone" {
  type = string
  description = "Zone name"
}

variable "pubsub" {
    type= map(object({
        name = string,
        sender = bool
    }))
  description = "pubsub confiuration"
}

