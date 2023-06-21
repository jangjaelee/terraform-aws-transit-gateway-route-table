variable "region" {
  description = "List of Allowed AWS account IDs"
  type        = string
}

variable "account_id" {
  description = "Allowed AWS account IDs"
  type        = list(string)
}

variable "prefix" {
  description = "prefix for aws resources and tags"
  type        = string
}

variable "tags" {
  description = "tag map"
  type        = map(string)
}

variable "create_tgw_rt" {
  description = "Controls if Transit Gateway Route Table should be created."
  type        = bool
}

variable "tgw_rt_name" {
  description = "Name to be used on all the resources as identifier for Transit Gateway Route Table"
  type        = string
}

variable "tgw_id" {
  description = "Identifier of AWS Transit Gateway"
  type        = string
}

variable "tgw_attachment_id" {
  description = "Identifier of AWS Transit Gateway Attachment"
  type        = map(any)
}

variable "tgw_routes" {
  description = "Informations of AWS Transit Gateway Routes"  
  type = list(any)
}