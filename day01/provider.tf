terraform {
  required_version = "> 1.7.0"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider docker {
   host = "unix:///var/run/docker.sock"
}