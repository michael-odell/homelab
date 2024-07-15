resource "maas_machine" "hpg2" {
  for_each = local.hpg2
  pxe_mac_address = each.value.mgmt_nic
  power_type = "manual"
  power_parameters = jsonencode({})
}

resource "maas_network_interface_physical" "hpg2-mgmt" {
  for_each = local.hpg2
  machine = maas_machine.hpg2[each.key].id
  mac_address = each.value.mgmt_nic
  lifecycle {
    ignore_changes = [vlan]
  }
}

resource "maas_network_interface_link" "hpg2-mgmt" {
  for_each = local.hpg2
  machine = maas_machine.hpg2[each.key].id
  network_interface = maas_network_interface_physical.hpg2-mgmt[each.key].id
  subnet = data.maas_subnet.mgmt.id
  mode = "DHCP"
}

resource "maas_network_interface_physical" "hpg2-data" {
  for_each = local.hpg2
  machine = maas_machine.hpg2[each.key].id
  mac_address = each.value.data_nic
  name = "eth1"
  lifecycle {
    ignore_changes = [vlan]
  }
}

resource "maas_network_interface_link" "hpg2-data" {
  for_each = local.hpg2
  machine = maas_machine.hpg2[each.key].id
  network_interface = maas_network_interface_physical.hpg2-data[each.key].id
  subnet = data.maas_subnet.data.id
  mode = "DHCP"
}

resource "maas_instance" "hpg2" {
  for_each = local.hpg2
}
