variable ssh_pub_key {
   type = string
   default = "chuk"
}

variable ssh_priv_key {
   description = "Path to private key"
   type = string
}

variable DO_image {
   type = string
   default = "ubuntu-20-04-x64"
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

variable code_server_archive {
   type = string
   default = "https://github.com/coder/code-server/releases/download/v4.22.1/code-server-4.22.1-linux-amd64.tar.gz"
}
variable unpacked_directory {
   type = string
   default = "code-server-4.22.1-linux-amd64"
}

variable code_server_password {
   type = string
   sensitive =  true
}