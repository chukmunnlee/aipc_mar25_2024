data digitalocean_ssh_key chuk {
  name = "chuk"
}

resource digitalocean_droplet aipc {
  name = "aipc"
  image = var.DO_image
  region = var.DO_region
  size = var.DO_size

  ssh_keys = [ data.digitalocean_ssh_key.chuk.id ] 

  connection {
    type = "ssh"
    user = "root"
    host = self.ipv4_address
    private_key = file(var.ssh_private_key_file)
  }

  /*
  provisioner remote-exec {
    inline = [
      "apt -y update",
      "apt -y --force-confnew upgrade"
    ]
  }
  */
}

resource local_file root_at_aipc {
  filename = "root@${digitalocean_droplet.aipc.ipv4_address}"
  content = ""
  file_permission = "0444"
}

resource local_file inventory_yaml {
  filename = "inventory.yaml"
  content = templatefile("./inventory.yaml.tftpl", {
    private_key_file = var.ssh_private_key_file,
    host = digitalocean_droplet.aipc.name,
    droplet_ip = digitalocean_droplet.aipc.ipv4_address
  })
}

output aipc_ipv4 {
  value = digitalocean_droplet.aipc.ipv4_address
}

output chuk_fingerprint {
  value = data.digitalocean_ssh_key.chuk.fingerprint
}
