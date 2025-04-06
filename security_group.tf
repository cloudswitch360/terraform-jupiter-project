# create security group for the web server
# terraform aws create security group
resource "aws_security_group" "cloudswitch360_jupiter_web_sg" {
  name        = "jupiter_web_sg"
  description = "Allow Internet access to the web server http port 80"
  vpc_id      = aws_vpc.cloudswitch360_project_vpc.id

  ingress {
    description = "Allow HTTP access from the Internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Server Security Group"
  }
}
