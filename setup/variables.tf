variable DO_token {
  type = string
  sensitive = true
}

variable ssh_private_key_file {
  type = string
  sensitive = true
}

variable DO_size {
  type = string
  default = "s-1vcpu-1gb"
}

variable DO_image {
  type = string
  default = "ubuntu-20-04-x64"
}
variable DO_region {
  type = string
  default = "sgp1"
}
