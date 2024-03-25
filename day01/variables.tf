
variable image_names {
   type = list(string)
   default = [ "chukmunnlee/dov-bear:v5", "chukmunnlee/mar11-fortune:v1.0.1" ]
}

variable container_ports {
   type = list(object({
      internal_port = number
      external_port = number
   }))
   default = [
      {
         internal_port = 3000
         external_port = 8080
      },
      {
         internal_port = 3000
         external_port = 9090
      }
   ]
}