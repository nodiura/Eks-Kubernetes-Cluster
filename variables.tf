variable "region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}
variable "subnet_cidrs" {
  description = "CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}
variable "availability_zones" {
  description = "The availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}
variable "cluster_name" {
  description = "The name of the EKS cluster"
  default     = "my-eks-cluster"
}