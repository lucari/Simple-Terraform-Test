# Global

variable "credentials_file" { }

variable "project_service_account" {
  description = "Service account to use for deployment"
  default = ""
}


variable "project_id" {
  description = "The ID of the network project in which the resources will be deployed."
  default     = ""
}

variable "region" {
  description = "Region to deploy the resources. Should be in the same region as the zone."
  default     = ""
}

variable "primary_zone" {
  description = "Zone to deploy the resources. Should be in the same region."
  default     = ""
}
variable "vpc_id" {
  description = "vpc id from infra deployment"
}

variable "subnet_name" {
  description = "Subnet name"
  default     = "da0"
}

variable "subnet_cidr" {
  description = "CIDR to be used"
}


variable "app_servers" {
  description = "App server details"
  default = ""
}

#variable "host_name" {
#  description = "Host name of the instance"
#  default = ""
#}
#
#variable "ip_address" {
#  description = "IP Address of the instance"
#  default = ""
#}
#
#
#variable "machine_type" {
#  description = "Machine type of the instance"
#  default = ""
#}
#
#variable "network_tags" {
#  description = "Network Tags"
#  default = ""
#}



