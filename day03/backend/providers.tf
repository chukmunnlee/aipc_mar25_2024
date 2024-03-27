terraform {
  required_version = "> 1.7.0"
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.36.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
  }

  backend s3 {
    skip_credentials_validation = true 
    skip_region_validation = true
    skip_metadata_api_check = true
    skip_requesting_account_id = true
    skip_s3_checksum = true
  }
}

provider digitalocean {
   token = var.DO_token
}

provider local { }
