sudo yum update -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y
sudo yum install java-17-amazon-corretto -y
sudo yum install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
echo "Here's Jenkins Initial admin password: $(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)"
     




# sudo wget -O /etc/yum.repos.d/jenkins.repo \
#     https://pkg.jenkins.io/redhat-stable/jenkins.repo
# sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
# sudo yum upgrade -y
# # Add required dependencies for the jenkins package
# sudo yum install java-21-amazon-corretto-headless -y 
# sudo yum install jenkins -y
# sudo systemctl daemon-reload
# sudo systemctl enable jenkins
# sudo systemctl start jenkins