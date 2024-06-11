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
resource "maas_instance" "bmcdemo-k3s" {
  count = 2
  allocate_params {
    min_cpu_count = 1
    min_memory    = 3072
  }
  deploy_params {
    user_data = templatefile("cloud-init-bmcdemo.yaml.tftpl", {system_type = "k3s"})
    distro_series = "noble"
  }
}

resource "maas_instance" "bmcdemo-db" {
  allocate_params {
    min_cpu_count = 1
    min_memory    = 3072
  }
  deploy_params {
    user_data = templatefile("cloud-init-bmcdemo.yaml.tftpl", {system_type = "db"})
    distro_series = "noble"
  }
}

resource "maas_tag" "bmcdemo" {
  name = "bmcdemo"
  machines = [
    maas_instance.bmcdemo-db.id,
    maas_instance.bmcdemo-k3s[0].id,
    maas_instance.bmcdemo-k3s[1].id,
  ]
}

resource "maas_tag" "db" {
  name = "db"
  machines = [
    maas_instance.bmcdemo-db.id
  ]
}

resource "maas_tag" "k3s" {
  name = "k3s"
  machines = [
    maas_instance.bmcdemo-k3s[0].id,
    maas_instance.bmcdemo-k3s[1].id,
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
