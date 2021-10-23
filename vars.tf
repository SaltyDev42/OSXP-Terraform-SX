variable "project" {
  type = string
}

variable "domain" {
  type = string
}

variable "login" {
  type = string
}

variable "user" {
  type = string
}

variable "pubkey" {
  type = string
}

variable "awxpubkey" {
  type = string
}

variable "ec2_type" {
  type = string
  default = "t2.small"
}

variable "region" {
  type = string
}

variable "ami" {
  type = string
}
