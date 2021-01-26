/* Staus of this template :  Run perfect  */
resource "aws_instance" "testVM_California" {
    provider = aws.California
    ami = "ami-03130878b60947df3"
    subnet_id = "subnet-4064401b"
    instance_type = "t2.small"
    count = 1
    key_name = "RadiousKeyPair-us-west-1"
    /* hard coded security group */
    security_groups = [ aws_security_group.kuber_example1_sg.id ]
 }

 resource aws_security_group "kuber_example1_sg"{
    name = "kuber_example_sg"
    ingress{
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]        
    }

    egress{
        from_port = 0
        protocol = "-1"
        to_port = 0
        cidr_blocks = ["0.0.0.0/0"]        
    }
 }