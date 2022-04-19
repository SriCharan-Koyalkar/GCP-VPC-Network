project_id = "spatial-lock-338613"

network_name = "my-custom-mode-network"

subnets = [
  {
    subnet_name               = "subnet-01"
    subnet_ip                 = "10.10.10.0/24"
    subnet_region             = "us-west1"
    subnet_private_access     = "true"
    subnet_flow_logs          = "true"
    subnet_flow_logs_interval = "INTERVAL_10_MIN"
    subnet_flow_logs_sampling = 0.7
    subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
  },
  {
    subnet_name               = "subnet-02"
    subnet_ip                 = "10.10.20.0/24"
    subnet_region             = "us-west1"
    subnet_private_access     = "true"
    subnet_flow_logs          = "true"
    subnet_flow_logs_interval = "INTERVAL_10_MIN"
    subnet_flow_logs_sampling = 0.7
    subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
  }
]
