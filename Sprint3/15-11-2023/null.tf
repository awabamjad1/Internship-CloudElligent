resource "null_resource" "this" {

  provisioner "local-exec" {
    command = <<-EOT
      docker push awabamjad/wordreversalbackend:latest
      docker push awabamjad/wordreversalfrontend:latest
    EOT
  }
}