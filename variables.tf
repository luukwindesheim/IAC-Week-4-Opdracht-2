variable "esxi_host" { type = string }
variable "esxi_user" { type = string }

variable "esxi_password" {
  type      = string
  sensitive = true
}

variable "datastore" { type = string } # bv. "datastore1"
variable "network" { type = string }   # bv. "VM Network"

variable "vm_name" {
  type    = string
  default = "ubuntu-01"

}

variable "ssh_pubkey" {
  type = string
}