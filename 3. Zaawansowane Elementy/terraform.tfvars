project = "hidden-terrain-384715"
region  = "us-central1"
zone    = "us-central1-a"
user    = "terraform"
names   = ["first", "second", "third"]
pubsub = {
  pub = {
    name   = "pub",
    sender = true
  },
  sub = {
    name   = "sub",
    sender = false
  }
}

subnets = [
  {
    subnet_name   = "subnet-01"
    subnet_ip     = "10.10.10.0/24"
    subnet_region = "us-central1"
  },
  {
    subnet_name   = "subnet-02"
    subnet_ip     = "10.10.20.0/24"
    subnet_region = "us-central1"
  },
  {
    subnet_name               = "subnet-03"
    subnet_ip                 = "10.10.30.0/24"
    subnet_region             = "us-central1"
    subnet_flow_logs          = "true"
    subnet_flow_logs_interval = "INTERVAL_10_MIN"
    subnet_flow_logs_sampling = 0.7
    subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
  }
]