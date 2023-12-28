resource "null_resource" "file_upload" {
  depends_on = [ aws_instance.this ]
  connection {
    type        = "ssh"
    host        = aws_instance.this.public_ip
    user        = "ubuntu"  
    private_key = file("ec2-awab.pem") 
  }

  provisioner "file" {
    source      = "frontend-deployment.yaml" 
    destination = "frontend-deployment.yaml" 
  }
  provisioner "file" {
    source      = "frontend-service.yaml"
    destination = "frontend-service.yaml" 
  }
  provisioner "remote-exec" {
    inline = [
      "kubectl apply -f frontend-deployment.yaml",
      "kubectl apply -f frontend-service.yaml",
      "kubectl port-forward service/frontend-service 8080:80"
    ]
  }
  
}

