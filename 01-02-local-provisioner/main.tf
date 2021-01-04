/* Staus of this template :  Run perfect  */
resource "aws_instance" "testVM_California" {
    provider = aws.California
    ami = "ami-03130878b60947df3"
    instance_type = "t2.micro"
    count = 1

   provisioner "local-exec" {
   
        #when = "create"
        # interpolated self.id since it is with in a command if not hen self.id will be 
        # identified as a string literal
        command = "echo ${self.id} >> vminfo"
  
    }

    

}
resource "aws_instance" "testVM_Oregon" {
    provider = aws.Oregon
    ami = "ami-0a36eb8fadc976275"
    instance_type = "t2.micro"
 
 
}