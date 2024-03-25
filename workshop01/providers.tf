terraform {
  required_version = "> 1.7.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.36.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider docker {
   host = "unix:///var/run/docker.sock"
}

provider digitalocean {
   token = var.DO_token
}

provider local { }
