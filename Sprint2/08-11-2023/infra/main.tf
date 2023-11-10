resource "docker_container" "frontend" {
  name  = "wordreversalfrontend"
  image = "wordreversalfrontend:latest"
  ports {
    internal = 80
    external = 80
  }
}
resource "docker_container" "backend" {
  name  = "wordreversalbackend"
  image = "wordreversalbackend:latest"
  ports {
    internal = 5000
    external = 5000
  }
}