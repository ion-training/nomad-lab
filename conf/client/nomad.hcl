datacenter = "dc1"
data_dir = "/opt/nomad"

bind_addr = "192.168.56.75"

advertise {
  http = "192.168.56.75"
}

client {
  enabled = true
  servers = ["192.168.56.71"]
  server_join {
    retry_join = [ "192.168.56.71"]
  }
}