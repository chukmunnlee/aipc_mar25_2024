data digitalocean_droplet docker_host {
  name = var.docker_host
}

data digitalocean_ssh_key ssh_pub_key {
  name = var.ssh_pub_key
}

/* create bgg deployment */
resource docker_network bgg-net {
  name = "bgg-net"
}

resource docker_volume data-vol {
  name = "data-vol"
}

resource docker_image bgg-database-image {
  name = "chukmunnlee/bgg-database:v3.1"
}
resource docker_image bgg-backend-image {
  name = "chukmunnlee/bgg-backend:v3"
}

resource docker_container bgg-database-container {
  name = "bgg-database"
  image = docker_image.bgg-database-image.image_id
  ports {
    internal = 3306
    external = 3306
  }
  networks_advanced {
    name = docker_network.bgg-net.name
  }
  volumes {
    volume_name = docker_volume.data-vol.name
    container_path = "/var/lib/mysql"
  }
}

resource docker_container bgg-backend-container {
  count = var.instance_count
  name = "bgg-backend-${count.index}"
  image = docker_image.bgg-backend-image.image_id
  ports {
    internal = 3000
  }
  env = [
    "BGG_DB_USER=root",
    "BGG_DB_PASSWORD=changeit",
    "BGG_DB_HOST=${docker_container.bgg-database-container.name}",
  ]

  networks_advanced {
    name = docker_network.bgg-net.name
  }
}

/* deploy nginx */
resource digitalocean_droplet nginx {
   name = "nginx"
   image = var.DO_image
   size = var.DO_size
   region = var.DO_region
   ssh_keys = [ data.digitalocean_ssh_key.ssh_pub_key.id ]

   connection {
      type = "ssh"
      user = "root"
      private_key = file(var.ssh_priv_key)
      host = self.ipv4_address
   }

   provisioner remote-exec {
      inline = [  
         "apt update -y",
         "apt install -y nginx",
         "systemctl enable nginx",
         "systemctl start nginx"
      ]
   }

   provisioner file {
      source = "nginx.conf"
      destination = "/etc/nginx/nginx.conf"
   }

   provisioner remote-exec {
      inline = [  
         "systemctl stop nginx",
         "systemctl start nginx"
      ]
   }
}

resource local_file nginx_conf {
   filename = "nginx.conf"
   content = templatefile("nginx.conf.tftpl", {
      container_ports = flatten([
        for ports in docker_container.bgg-backend-container[*].ports: [
          for p in ports: p.external if p.internal == 3000
        ]
      ])
      docker_host_ip = data.digitalocean_droplet.docker_host.ipv4_address
   })
   file_permission = "0444"
}

resource local_file root_at_ip {
   filename = "root@${digitalocean_droplet.nginx.ipv4_address}"
   content = ""
   file_permission = "0444"
}

output aipc_ipv4 {
  value = data.digitalocean_droplet.docker_host.ipv4_address
}

output nginx_ipv4 {
  value = digitalocean_droplet.nginx.ipv4_address
}

output ports {
  value = flatten([
    for ports in docker_container.bgg-backend-container[*].ports: [
      for p in ports: p.external if p.internal == 3000
    ]
  ])
}
