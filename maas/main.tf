locals {
  ms01 = {
    ms01-a = {
      zone = "a"
      mgmt_nic = "58:47:ca:77:25:d4"
      data_nic = "58:47:ca:77:25:d2"
    }
    ms01-b = {
      zone = "b"
      mgmt_nic = "58:47:ca:77:29:10"
      data_nic = "58:47:ca:77:29:0e"
    }
    ms01-c = {
      zone = "c"
      mgmt_nic = "58:47:ca:77:31:b8"
      data_nic = "58:47:ca:77:31:b6"
    }
  }

  hpg2 = {
    hpg2-a = {
      zone = "a"
      mgmt_nic = "ec:8e:b5:73:4c:ef"
      data_nic = "6c:1f:f7:06:21:c2"
    }
  }
}

data "maas_subnet" "data" {
  cidr = "10.243.243.0/24"
}

data "maas_subnet" "mgmt" {
  cidr = "192.168.243.0/24"
}


resource "maas_machine" "ms01" {
  for_each = local.ms01
  pxe_mac_address = each.value.mgmt_nic
  power_type = "manual"
  power_parameters = jsonencode({})

  hostname = each.key
  domain = "mgmt"
  zone = each.value.zone
}

resource "maas_network_interface_physical" "ms01-mgmt" {
  for_each = local.ms01
  machine = maas_machine.ms01[each.key].id
  mac_address = each.value.mgmt_nic
  name = "eth0"
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

resource "maas_network_interface_physical" "ms01-data" {
  for_each = local.ms01
  machine = maas_machine.ms01[each.key].id
  mac_address = each.value.data_nic
  name = "eth1"
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

resource "maas_instance" "ms01" {
  for_each = local.ms01
}

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
  name = "eth0"
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

##data "maas_machine" "a" {
##  pxe_mac_address = "58:47:ca:77:25:d4"
##}
#
#resource "maas_tag" "physical" {
#  name = "physical"
#}
#
#resource "maas_tag" "virtual" {
#  name = "virtual"
#}
#
#resource "maas_tag" "hotpotato" {
#  name = "hotpotato"
#}
#
##resource "maas_vm_host" "active-foal" {
##  type = "lxd"
##
##  machine = "active-foal.maas"
##  tags = [
##    "hotpotato"
##  ]
##
##}
#
#resource "maas_instance" "bmcdemo-k3s" {
#  count = 2
#  allocate_params {
#    min_cpu_count = 1
#    min_memory    = 3072
#  }
#  deploy_params {
#    user_data = templatefile("cloud-init-bmcdemo.yaml.tftpl", {system_type = "k3s"})
#    distro_series = "noble"
#  }
#}
#
#resource "maas_instance" "bmcdemo-db" {
#  allocate_params {
#    min_cpu_count = 1
#    min_memory    = 3072
#  }
#  deploy_params {
#    user_data = templatefile("cloud-init-bmcdemo.yaml.tftpl", {system_type = "db"})
#    distro_series = "noble"
#  }
#}
#
#resource "maas_tag" "bmcdemo" {
#  name = "bmcdemo"
#  machines = [
#    maas_instance.bmcdemo-db.id,
#    maas_instance.bmcdemo-k3s[0].id,
#    maas_instance.bmcdemo-k3s[1].id,
#  ]
#}
#
#resource "maas_tag" "db" {
#  name = "db"
#  machines = [
#    maas_instance.bmcdemo-db.id
#  ]
#}
#
#resource "maas_tag" "k3s" {
#  name = "k3s"
#  machines = [
#    maas_instance.bmcdemo-k3s[0].id,
#    maas_instance.bmcdemo-k3s[1].id,
#  ]
#}
#
#
## This was working for active-foal until I accidentally tained the state with it powered off and now
## without wanting to bootstrap the node again, I should probably leave it commented out
##resource "maas_instance" "active-foal" {
##  allocate_params {
##    #tags = ["hotpotato"]
##    hostname = "active-foal"
##  }
##  deploy_params {
##    distro_series = "noble"
##    user_data = file("cloud-init.yaml")
##  }
##}
#
##resource "maas_instance" "b" {
##  allocate_params {
##
##  }
##  deploy_params {
##    distro_series = "noble"
##    user_data = file("cloud-init.yaml")
##  }
##}
