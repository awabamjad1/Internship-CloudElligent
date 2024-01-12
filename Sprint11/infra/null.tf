resource "null_resource" "file_upload_public_ec2" {
  depends_on = [ aws_instance.public ]
  connection {
    type        = "ssh"
    host        = aws_instance.public.public_ip
    user        = "ubuntu"  
    private_key = file("ec2-awab.pem") 
  }

  provisioner "file" {
    source      = "ec2-private.pem" 
    destination = "ec2-private.pem" 
  }
  provisioner "remote-exec" {
    inline = [
      "chmod 400 \"ec2-private.pem\""
    ]
  }
  
}
resource "null_resource" "file_upload_public_s3" {
  depends_on = [ aws_s3_bucket.this ]
  provisioner "local-exec" {
    command = <<-EOT
      aws s3 cp sample.txt s3://apptestawab/sample.txt
    EOT
  }
}

