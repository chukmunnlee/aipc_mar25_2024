// docker pull chukmunnlee/dov-bear:v5
resource docker_image app-images {
   count = length(var.image_names)
   name = var.image_names[count.index]
}

// docker run -d -P --name dov-bear chukmunnlee/dov-bear:v5
resource docker_container app-container {
   count = length(var.image_names)
   name = "app-container-${count.index}"
   image = docker_image.app-images[count.index].image_id
   ports {
      internal = var.container_ports[count.index].internal_port
      external = var.container_ports[count.index].external_port
   }
}

output app-container-ports {
   description = "external ports bound to container port"
   value = [ 
      for p in docker_container.app-container[*].ports: p[0].external
   ]
}