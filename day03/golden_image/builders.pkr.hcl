source digitalocean nginx_snapshot {
  api_token = var.DO_token
  image = var.DO_image
  size = var.DO_size
  region = var.DO_region
  snapshot_name = var.snapshot_name
  ssh_username = "root"
}

build {
  sources = [ "source.digitalocean.nginx_snapshot" ]

  provisioner ansible {
    playbook_file = "playbook.yaml"
    /*
    ansible_ssh_extra_args = [
      "-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=+ssh-rsa"
    ]
    */
  }
}
