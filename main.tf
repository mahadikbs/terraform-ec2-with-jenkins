resource "aws_key_pair" "my_key" {
    key_name = var.ssh-key-name
    public_key = file("~/.ssh/my-ec2-key.pub")
  
}

resource "aws_instance" "terraform-test" {
    ami = var.ami-id
    instance_type = var.instance-type
    key_name = aws_key_pair.my_key.key_name
    vpc_security_group_ids = var.security-group

    tags = {
      Name = "tf-Jenkins-and-prometheus-1012434"
    }

    provisioner "file" {
        source = "jenkins.sh"
        destination = "/home/ec2-user/install-jenkins.sh"
  } 
    provisioner "file" {
        source = "prom/prom1.sh"
        destination = "/home/ec2-user/install-prom1.sh"
}      
    provisioner "file" {
        source = "prom/prom2.sh"
        destination = "/home/ec2-user/install-prom2.sh"
} 
    provisioner "file" {
        source = "prom/prom.service"
        destination = "/home/ec2-user/prometheus.service"
}     
    provisioner "remote-exec" {
        inline = [ 
            "sudo cd /home/ec2-user/",
            "sudo chmod +x install-jenkins.sh",
            "sudo ./install-jenkins.sh",
            "echo installing prometheus",
            "sudo chmod +x install-prom1.sh",
            "sudo ./install-prom1.sh"      
         ]
    }

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/.ssh/my-ec2-key")
      host = self.public_ip
    }
}

# generate prometheus config file with public ip

resource "template_file" "prometheus-config" {
    template = file("prom/prometheus_config.yml.tpl")

    vars = {
      PUBLIC_IP = aws_instance.terraform-test.public_ip
    }

provisioner "remote-exec" {
    inline = [ 
        "echo '${template_file.prometheus_config.rendered} | sudo tee /etc/prometheus/prometheus.yml"
     ]

}

provisioner "remote-exec" {
    inline = [ 
        "sudo -u prometheus /usr/local/bin/prometheus --config.file /etc/prometheus/prometheus.yml --storage.tsdb.path /var/lib/prometheus --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries",
        "sudo cp -rv /home/ec2-user/prometheus.service /etc/systemd/system/",
        "sudo cd /home/ec2-user/",
        "sudo chmod +x install-prom2.sh",
        "sudo ./install-prom2.sh"
     ]
  
}


}