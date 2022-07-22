variable "global_settings" {}

variable "resource_group" {}

variable "vnet" {
    default = {}
}

variable "subnet" {
    default = {}
}

variable "nsg" {
    default = {}
}

variable "nsg_subnet_association" {
    default = {}
}
