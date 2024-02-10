variable "environment" {
  type        = string
  description = "The environment the resource is being provisioned to"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "project_name" {
  type        = string
  description = "Project Name for resources created"
}
