resource "aws_key_pair" "my_key" {
    key_name = var.ssh-key-name
    public_key = file("~/.ssh/id_rsa.pub")
  
}

resource "aws_instance" "terraform-test" {
    ami = var.ami-id
    instance_type = var.instance-type
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = var.security-group

    tags = {
      Name = "tf-Jenkins-1012434"
    }

    provisioner "remote-exec" {
        inline = [ 
          
          "curl -sSL \"https://raw.githubusercontent.com/mahadikbs/required-software/main/custom/jenkins_amzn_lnx.sh\" | bash"

         ]
    }

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }
}
