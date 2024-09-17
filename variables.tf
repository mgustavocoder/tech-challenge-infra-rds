variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "tf_bucket" {
  description = "Bucket to Store the state file"
  type        = string
  default     = "terraform-state-tech-challenge"
}

variable "region" {
  description = "The AWS region to deploy the resources in"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "The VPC ID where the Aurora cluster and other resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the Aurora cluster"
  type        = list(string)
}

variable "cluster_identifier" {
  description = "The identifier for the Aurora MySQL cluster"
  type        = string
  default     = "postech-tch-fiap"
}

variable "master_username" {
  description = "The master username for the Aurora MySQL cluster"
  type        = string
}

variable "master_password" {
  description = "The master password for the Aurora MySQL cluster"
  type        = string
}
