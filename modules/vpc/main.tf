
resource "aws_vpc" "foodtech_eks_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  
  tags = {
    Name        = "foodtech_eks_vpc"            
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}

resource "aws_subnet" "subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.foodtech_eks_vpc.id
  cidr_block              = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true

  tags = {
    Name        = "eks_subnet_${count.index == 0 ? "a" : "b"}"
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}

resource "aws_internet_gateway" "eks_igw" {
  vpc_id = aws_vpc.foodtech_eks_vpc.id

  tags = {
    Name        = "foodtech_eks_igw"          
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}

resource "aws_route_table" "eks_route_table" {
  vpc_id = aws_vpc.foodtech_eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks_igw.id
  }

  tags = {
    Name        = "eks_route_table"          
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}

resource "aws_route_table_association" "subnet_association" {
  count          = 2
  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.eks_route_table.id
}

output "vpc_id" {
  value = aws_vpc.foodtech_eks_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.subnet[*].id
}

output "security_group_id" {
  value = aws_security_group.foodtech_eks_securitygroup.id
}

resource "aws_security_group" "foodtech_eks_securitygroup" {
  vpc_id      = aws_vpc.foodtech_eks_vpc.id
  description = "EKS node security group"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "foodtech_eks_securitygroup"          
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}
