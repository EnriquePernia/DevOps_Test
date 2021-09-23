variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}
variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "aws_key" {
    type = string
    description = "aws key"
}

variable "aws_vpc" {
  type = string
  description = "aws vpc"
}

variable "aws_az" {
  type = list
  description = "aws az"
}

variable "aws_inst_type" {
  type = string
  description = "aws instance type"
}

variable "aws_image_id" {
  type = string
  description = "aws image id"
}