provider "aws" {
  region = var.region
}
resource "aws_vpc" "eks_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
}
resource "aws_subnet" "eks_subnet_a" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
}
resource "aws_subnet" "eks_subnet_b" {
  vpc_id            = aws_vpc.eks_vpc.id
  cidr_block        = var.subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
}
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn
  vpc_config {
    subnet_ids = [
      aws_subnet.eks_subnet_a.id,
      aws_subnet.eks_subnet_b.id,
    ]
  }
}
resource "aws_iam_role" "eks_role" {
  name = "${var.cluster_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "eks.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}
resource "aws_iam_role_policy_attachment" "eks_policy_attachment" {
  role       = aws_iam_role.eks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_security_group" "eks_security_group" {
  name        = "${var.cluster_name}-sg"
  vpc_id      = aws_vpc.eks_vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # In a real setup use a more restrictive CIDR block
  }
}