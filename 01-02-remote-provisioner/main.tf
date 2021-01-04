/* Staus of this template :  Run perfect and well... Awesome Job!! */
resource "aws_instance" "testVM_California" {
    # Few changes to this remplate.key_name
    # ami value is picked up dynamically
    # We are adding a ssh key since we want to execute a script remotelifecycle 
    # we are also specifying a list of security group to the VPC security groups  
    #provider = aws.California
    #ami = aws_ami.ami.id
    ami = "ami-03130878b60947df3"
    instance_type = "t2.micro"
    key_name = aws_key_pair.ssh.key_name
    //key_name = "RadiousKeyPair-us-west-1"
    vpc_security_group_ids = [ aws_security_group.remote_exec_sg.id ]
  
}
/*
resource "aws_instance" "testVM_Oregon" {
    provider = aws.Oregon
    ami = "ami-0a36eb8fadc976275"
    instance_type = "t2.micro"
}
*/

resource "null_resource" "remote_exec_null" {
    triggers = {
        public_ip = aws_instance.testVM_California.public_ip
    }

    connection {
        type = "ssh"
        host = aws_instance.testVM_California.public_ip
        private_key = file("C:\\Tools\\terraform\\terraform-project\\Terraform-Samples\\MyKeyPair.pem")
        user = "ec2=user"
        timeout = "1m"
    }

    /* provider "remote-exec" {
        # command to pass
        inline = ["sudo yum -y update", "sudo yum install -y httpd", "sudo service httpd start"]
    } */
}

resource aws_key_pair "ssh" {
    key_name = "MyKeyPair"
    tags = {
      "Purpose" = "remote_exec"
      "Created_By" = "Anand"
    }
    /* you can create a key pair using the console. It will download the the key pair
       then use the ssh-keygen -y -f << file location & name >>  and then out put to your keyname.pub
       Make sure that the file is only readable by the user
       do a chmod 400 on the file for it to be readable only by you. for read and writable use chmod 600
       if running on windows go the file properties and make sure the object is only readable by the user
       */
    public_key = file("C:\\Tools\\terraform\\terraform-project\\Terraform-Samples\\MyKeyPair.pub")
}


resource aws_security_group "remote_exec_sg"{
    name = "remote_exec_sg"
    ingress{
        from_port = 22
        protocol = "tcp"
        to_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress{
        from_port = 80
        protocol = "tcp"
        to_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]        
    }

 provisioner "remote-exec" {
    inline = ["sudo yum -y update", "sudo yum install -y httpd", "sudo service httpd start", "echo '<!doctype html><html><body><h1>CONGRATS!!..You have configured successfully your remote exec provisioner!</h1></body></html>' | sudo tee /var/www/html/index.html"]
  }
}

