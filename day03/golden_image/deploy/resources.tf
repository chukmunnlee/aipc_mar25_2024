data digitalocean_ssh_key ssh_pub {
   name = var.ssh_pub_key
}

data digitalocean_image nginx_snapshot {
  name = var.snapshot_name
}

resource digitalocean_droplet nginx {
   name = "nginx"
   image = data.digitalocean_image.nginx_snapshot.id
   size = var.DO_size
   region = var.DO_region
   ssh_keys = [ data.digitalocean_ssh_key.ssh_pub.id ]
}


resource local_file root_at_ip {
   filename = "root@${digitalocean_droplet.nginx.ipv4_address}"
   content = ""
   file_permission = "0444"
}

output nginx_ipv4 {
   value = digitalocean_droplet.nginx.ipv4_address
}

output snapshot_status {
  value = data.digitalocean_image.nginx_snapshot.status
}
