variable instance_count {
   type = number
   default = 3
}

variable ssh_pub_key {
   type = string
   default = "chuk"
}

variable ssh_priv_key {
   description = "Path to private key"
   type = string
}

variable docker_host {
   type = string
   default = "aipc"
}
variable ports {
   type = list(
      object({
         internal_port = number
         external_port = number
      })
   )
}

variable DO_image {
   type = string
   default = "ubuntu-20-04-x64"
}

variable DO_size {
   type = string
   default = "s-1vcpu-1gb"
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
