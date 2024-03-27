data digitalocean_ssh_key ssh_pub {
   name = var.ssh_pub_key
}

resource digitalocean_droplet codeserver {
   name = "codeserver-${terraform.workspace}"
   image = var.DO_image
   size = var.DO_size
   region = var.DO_region
   ssh_keys = [ data.digitalocean_ssh_key.ssh_pub.id ]
}


resource local_file root_at_ip {
   filename = "root@${digitalocean_droplet.codeserver.ipv4_address}"
   content = ""
   file_permission = "0444"
}

output codeserver_ipv4 {
   value = digitalocean_droplet.codeserver.ipv4_address
}
