data digitalocean_ssh_key chuk_ssh_pub {
   name = var.ssh_pub_key
}

resource digitalocean_droplet mydroplet {
   name = "mydroplet"
   image = var.DO_image
   size = var.DO_size
   region = var.DO_region
   ssh_keys = [ data.digitalocean_ssh_key.chuk_ssh_pub.id ]

   connection {
      type = "ssh"
      user = "root"
      private_key = file(var.ssh_priv_key)
      host = self.ipv4_address
   }
}

resource local_file inventory_yaml {
   filename = "inventory.yaml"
   content = templatefile("inventory.yaml.tftpl", {
      host_name = digitalocean_droplet.mydroplet.name
      droplet_ipv4 = digitalocean_droplet.mydroplet.ipv4_address
      ssh_private_key_file = var.ssh_priv_key
      date = timestamp()
   })
   file_permission = "0444"
}

resource local_file root_at_ip {
   filename = "root@${digitalocean_droplet.mydroplet.ipv4_address}"
   content = ""
   file_permission = "0444"
}

output mydroplet_ipv4 {
   value = digitalocean_droplet.mydroplet.ipv4_address
}
