
variable "vpc_id" {
  description = "VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets where the EKS cluster will be deployed"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the EKS cluster"
  type        = string
}

variable "eks_role_arn" {
  description = "IAM Role ARN for the EKS cluster"
  type        = string
}

variable "node_group_role_arn" {
  description = "IAM Role ARN for the EKS node group"
  type        = string
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "foodtech-eks-cluster"
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.security_group_id]
  }

  tags = {
    Name        = "foodtech-eks-cluster"          
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
}  

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "foodtech-node-group"
  node_role_arn   = var.node_group_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  tags = {
    Name        = "foodtech-node-group"          
    Project     = "foodtech_project"   
    Environment = "prod"               
    Owner       = "Grupo27-6SOAT"             
  }
} 

output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}
