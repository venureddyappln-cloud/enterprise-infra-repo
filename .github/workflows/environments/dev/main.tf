# 5. Create a Security Group (Virtual Firewall) for Web Application Servers
resource "aws_security_group" "web_sg" {
  name        = "dev-web-server-sg"
  description = "Allow secure web traffic into application tier"
  vpc_id      = aws_vpc.dev_vpc.id

  # Inbound Rule: Allow secure web traffic (HTTPS) from anywhere
  ingress {
    description = "Allow HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: Allow standard web traffic (HTTP) from anywhere
  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule: Allow the server to download updates safely from the internet
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "dev-web-security-group"
    Environment = "dev"
  }
}

