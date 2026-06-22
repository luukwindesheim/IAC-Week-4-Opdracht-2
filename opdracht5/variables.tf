variable "esxi_host" { type = string }
variable "esxi_user" { type = string }

variable "esxi_password" {
  type      = string
  sensitive = true
}

variable "datastore" { type = string }
variable "network" { type = string }

variable "ssh_pubkey" { type = string }
