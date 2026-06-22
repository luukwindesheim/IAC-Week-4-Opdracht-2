locals {
  vms = {
    "web-1" = { group = "web" }
    "web-2" = { group = "web" }
    "db-1"  = { group = "db" }
  }
}

resource "esxi_guest" "vm" {
  for_each = local.vms

  guest_name    = each.key
  disk_store    = var.datastore
  ovf_source    = "https://cloud-images.ubuntu.com/releases/22.04/release/ubuntu-22.04-server-cloudimg-amd64.ova"
  boot_firmware = "efi"
  guestos       = "ubuntu-64"
  numvcpus      = 1
  memsize       = 1024
  boot_disk_type = "thin"
  boot_disk_size = 20
  power          = "on"

  network_interfaces {
    virtual_network = var.network
  }

  guestinfo = {
    "metadata"          = base64encode("instance-id: ${each.key}\nlocal-hostname: ${each.key}\n")
    "metadata.encoding" = "base64"
    "userdata"          = base64encode(templatefile("${path.module}/../userdata.yaml", {
      admin_user = var.esxi_user
      ssh_pubkey = file(var.ssh_pubkey)
    }))
    "userdata.encoding" = "base64"
  }
}

resource "local_file" "ansible_inventory" {
  filename = "${path.module}/inventory.ini"

  content = <<EOF
[web]
${esxi_guest.vm["web-1"].ip_address} ansible_user=${var.esxi_user}
${esxi_guest.vm["web-2"].ip_address} ansible_user=${var.esxi_user}

[db]
${esxi_guest.vm["db-1"].ip_address} ansible_user=${var.esxi_user}
EOF
}
