provider "vsphere" {
  user           = yamldecode(file("~/.config/ocp/vsphere.yaml"))["vsphere-user"]
  password       = yamldecode(file("~/.config/ocp/vsphere.yaml"))["vsphere-password"]
  vsphere_server = yamldecode(file("~/.config/ocp/vsphere.yaml"))["vsphere-server"]

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = yamldecode(file("~/.config/ocp/vsphere.yaml"))["vsphere-dc"]
}

data "vsphere_compute_cluster" "cluster" {
  name          = yamldecode(file("~/.config/ocp/vsphere.yaml"))["vsphere-cluster"]
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "mx1tb" {
  name          = "mx1tb"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "RHCOS" {
  name          = "rhcos-4.5.6"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "nvme500" {
  name          = "nvme500"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

variable "bootstrap_mac" {
    description = "OCP 4 Bootstrap MAC Address"
    type        = string
    default     = "00:50:56:b1:c7:ae"
}

variable "bootstrap_ignition_url" {
    #base64string
    default = "ewogICJpZ25pdGlvbiI6IHsKICAgICJjb25maWciOiB7CiAgICAgICJhcHBlbmQiOiBbCiAgICAgICAgewogICAgICAgICAgInNvdXJjZSI6ICJodHRwOi8vMTkyLjE2OC4xLjE2MDo4MDgwL2lnbml0aW9uL2Jvb3RzdHJhcC5pZ24iLAogICAgICAgICAgInZlcmlmaWNhdGlvbiI6IHt9CiAgICAgICAgfQogICAgICBdCiAgICB9LAogICAgInRpbWVvdXRzIjoge30sCiAgICAidmVyc2lvbiI6ICIyLjEuMCIKICB9LAogICJuZXR3b3JrZCI6IHt9LAogICJwYXNzd2QiOiB7fSwKICAic3RvcmFnZSI6IHt9LAogICJzeXN0ZW1kIjoge30KfQ=="
}
