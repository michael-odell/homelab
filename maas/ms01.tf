
resource "maas_machine" "ms01" {
  for_each = local.ms01
  pxe_mac_address = each.value.mgmt_nic
  power_type = "manual"
  power_parameters = jsonencode({})

  hostname = each.key
  domain = "mgmt"
  zone = each.value.zone
}

resource "maas_network_interface_physical" "ms01-data" {
  for_each = local.ms01
  machine = maas_machine.ms01[each.key].id
  mac_address = each.value.data_nic
  name = "eth0"
  lifecycle {
    ignore_changes = [vlan]
  }
}

resource "maas_network_interface_link" "ms01-data" {
  for_each = local.ms01
  machine = maas_machine.ms01[each.key].id
  network_interface = maas_network_interface_physical.ms01-data[each.key].id
  subnet = data.maas_subnet.data.id
  mode = "DHCP"
}

resource "maas_network_interface_physical" "ms01-mgmt" {
  for_each = local.ms01
  machine = maas_machine.ms01[each.key].id
  mac_address = each.value.mgmt_nic
  name = "eth1"
  lifecycle {
    ignore_changes = [vlan]
  }
}

resource "maas_network_interface_link" "ms01-mgmt" {
  for_each = local.ms01
  machine = maas_machine.ms01[each.key].id
  network_interface = maas_network_interface_physical.ms01-mgmt[each.key].id
  subnet = data.maas_subnet.mgmt.id
  mode = "DHCP"
}

resource "maas_instance" "ms01" {
  for_each = local.ms01

  deploy_params {
    user_data = templatefile("cloud-init.yaml.tftpl", {foo = "bar"})
    distro_series = "noble"
  }
}

