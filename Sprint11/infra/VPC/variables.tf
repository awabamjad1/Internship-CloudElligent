variable "region" {
  description = "AWS region where the resources will be created"
  type        = string
}
variable "project_name" {
  description = "Sprint 11 Project: "
  default     = "Sprint 11 Project"
  type        = string
}

variable "team_name" {
  description = "Cloud Intern"
  default     = "Cloud"
  type        = string
}
variable "environment" {
  description = "Specifying environment"
  default     = "Test"
  type        = string
}
variable "CIDR" {
  description = "CIDR block of VPC"
  type        = string
}
variable "Name" {
  description = "Name of VPC"
  type        = string
}