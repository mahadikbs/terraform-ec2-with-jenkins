resource "aws_key_pair" "my_key" {
    key_name = var.ssh-key-name
    public_key = file("~/.ssh/my-ec2-key.pub")
}

resource "aws_instance" "terraform-test" {
    ami = var.ami-id
    instance_type = var.instance-type
    key_name = aws_key_pair.my_key.key_name
    security_groups =  [var.security-group]   

    tags = {
      Name = tf-jenkins-1012434
    }
  
}