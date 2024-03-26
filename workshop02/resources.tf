data digitalocean_ssh_key ssh_pub {
   name = var.ssh_pub_key
}

resource digitalocean_droplet codeserver {
   name = "codeserver"
   image = var.DO_image
   size = var.DO_size
   region = var.DO_region
   ssh_keys = [ data.digitalocean_ssh_key.ssh_pub.id ]
}

resource local_file inventory_yaml {
   filename = "inventory.yaml"
   content = templatefile("inventory.yaml.tftpl", {
      host_name = digitalocean_droplet.codeserver.name
      ssh_private_key_file = var.ssh_priv_key
      droplet_ipv4 = digitalocean_droplet.codeserver.ipv4_address
      code_server_archive = var.code_server_archive
      unpacked_directory  = var.unpacked_directory
      code_server_password = var.code_server_password
      code_server_domain = "code-server.${digitalocean_droplet.codeserver.ipv4_address}.nip.io"
      ts = timestamp()
   })
   file_permission = "0444"
}

resource local_file root_at_ip {
   filename = "root@${digitalocean_droplet.codeserver.ipv4_address}"
   content = ""
   file_permission = "0444"
}

output codeserver_ipv4 {
   value = digitalocean_droplet.codeserver.ipv4_address
}

output code_server_domain {
   value = "code-server.${digitalocean_droplet.codeserver.ipv4_address}.nip.io"
}