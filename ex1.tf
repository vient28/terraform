variable myimage {
  default = "5f8794fe-c140-4bda-9280-e8f6ca3774ba"
}

variable myflavor {
  default = "0"
}


resource "openstack_compute_instance_v2" "test" {
        name = "test"
        image_id = "${var.myimage}"
        flavor_id = "${var.myflavor}"
        security_groups = ["default"]
        network {
            uuid = "e38b7dbd-758d-40eb-9069-39c869f470a9"
        }
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public1"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.test.id}"
}

output "vm-name" {
  value = "${openstack_compute_instance_v2.test.name}"
}

output "vm-id" {
  value = "${openstack_compute_instance_v2.test.id}"
}

output "vm-ip" {
        value = "${openstack_compute_instance_v2.test.network.0.fixed_ip_v4}"
}
root@openwhisk:/home/ubuntu/ex1# cat ex1.tf
variable myimage {
  default = "5f8794fe-c140-4bda-9280-e8f6ca3774ba"
}

variable myflavor {
  default = "0"
}


resource "openstack_compute_instance_v2" "test" {
        name = "test"
        image_id = "${var.myimage}"
        flavor_id = "${var.myflavor}"
        security_groups = ["default"]
        network {
            uuid = "e38b7dbd-758d-40eb-9069-39c869f470a9"
        }
}

resource "openstack_networking_floatingip_v2" "fip_1" {
  pool = "public1"
}

resource "openstack_compute_floatingip_associate_v2" "fip_1" {
  floating_ip = "${openstack_networking_floatingip_v2.fip_1.address}"
  instance_id = "${openstack_compute_instance_v2.test.id}"
}

output "vm-name" {
  value = "${openstack_compute_instance_v2.test.name}"
}

output "vm-id" {
  value = "${openstack_compute_instance_v2.test.id}"
}

output "vm-ip" {
        value = "${openstack_compute_instance_v2.test.network.0.fixed_ip_v4}"
}