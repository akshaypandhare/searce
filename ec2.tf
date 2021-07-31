data "aws_ami" "example" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}


resource "aws_instance" "web" {
  ami           = data.aws_ami.example.id
  instance_type = lookup(var.instance_type,terraform.workspace)

  tags = {
    Name = "test_terraform"
  }
}

variable "instance_type" {
   type = map
   default = {
     default = "t2.nano"
     dev     = "t2.micro"
     prod    = "t2.large"
 }
}
