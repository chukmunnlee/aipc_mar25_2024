terraform {
  required_version = "> 1.7.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.27.0"
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

provider cloudflare {
   api_token = var.CF_token
}

provider digitalocean {
   token = var.DO_token
}

provider local { }
