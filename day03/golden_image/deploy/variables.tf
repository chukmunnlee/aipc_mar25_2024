variable ssh_pub_key {
   type = string
   default = "chuk"
}

variable DO_size {
   type = string
   default = "s-1vcpu-2gb"
}

variable DO_region {
   type = string
   default = "sgp1"
}

variable DO_token {
   description = "DO token"
   type = string
   sensitive = true
}

variable snapshot_name {
  type = string
  default = "mysnapshot"
}
