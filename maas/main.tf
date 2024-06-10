data "maas_subnet" "pxe" {
  cidr = "192.168.243.0/24"
}

resource "maas_resource_pool" "pool_test" {
  name = "pool_test"
}

#data "maas_machine" "a" {
#  pxe_mac_address = "58:47:ca:77:25:d4"
#}

resource "maas_tag" "physical" {
  name = "physical"
}

resource "maas_tag" "virtual" {
  name = "virtual"
}

resource "maas_tag" "hotpotato" {
  name = "hotpotato"
}

#resource "maas_vm_host" "active-foal" {
#  type = "lxd"
#
#  machine = "active-foal.maas"
#  tags = [
#    "hotpotato"
#  ]
#
#}

resource "maas_instance" "bmcdemo" {
  allocate_params {
    min_cpu_count = 1
    min_memory    = 2048
  }
  deploy_params {
    user_data = file("cloud-init-bmcdemo.yaml")
    distro_series = "noble"
  }
}

resource "maas_tag" "bmcdemo" {
  name = "bmcdemo"
  machines = [
    maas_instance.bmcdemo.id
  ]
}


# This was working for active-foal until I accidentally tained the state with it powered off and now
# without wanting to bootstrap the node again, I should probably leave it commented out
#resource "maas_instance" "active-foal" {
#  allocate_params {
#    #tags = ["hotpotato"]
#    hostname = "active-foal"
#  }
#  deploy_params {
#    distro_series = "noble"
#    user_data = file("cloud-init.yaml")
#  }
#}

#resource "maas_instance" "b" {
#  allocate_params {
#
#  }
#  deploy_params {
#    distro_series = "noble"
#    user_data = file("cloud-init.yaml")
#  }
#}
