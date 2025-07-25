provider "aws" {
- task: TerraformTask@5
  inputs:
    provider: 'aws'
    command: 'init'
    backendServiceAWS: 'aws'
    backendAWSBucketName: 'test-bucket-dev-env1'
    backendAWSKey: 'main'
  region = "us-east-1" # Change to your preferred region
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "vpc-0d2fbffad834b663c"  # Replace with your actual VPC ID

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Be careful, this allows SSH from anywhere
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SSH-SG"
  }
}
