// docker pull chukmunnlee/dov-bear:v5
resource docker_image dov-bear {
   name = var.image_name
}

// docker run -d -P --name dov-bear chukmunnlee/dov-bear:v5
resource docker_container dov-container {
   name = "dov-bear"
   image = docker_image.dov-bear.image_id
   ports {
      internal = var.container_port
      external = var.external_port
   }
}

output dov-bear-digest {
   description = "repo digest of the image"
   value = docker_image.dov-bear.repo_digest
}

output dov-container-external-ports {
   description = "external ports bound to container port"
   value = docker_container.dov-container.ports
}