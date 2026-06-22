resource "esxi_guest" "ubuntu" {
  guest_name = var.vm_name
  disk_store = var.datastore

  numvcpus = 1
  memsize  = 1024

  boot_firmware = "efi"
  guestos       = "ubuntu-64"

  network_interfaces {
    virtual_network = var.network
  }

  boot_disk_type = "thin"
  boot_disk_size = 20

  power = "on"

  extra_config = {
    "guestinfo.metadata"          = base64encode(file("${path.module}/metadata.yaml"))
    "guestinfo.metadata.encoding" = "base64"

    "guestinfo.userdata" = base64encode(templatefile("${path.module}/userdata.yaml", {
      admin_user = var.esxi_user
      ssh_pubkey = file(var.ssh_pubkey)
    }))
    "guestinfo.userdata.encoding" = "base64"
  }
}


resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"

  content = <<EOF
[ubuntu]
${esxi_guest.ubuntu.ip_address} app_name=demoapp ansible_user=${var.esxi_user}
EOF
}