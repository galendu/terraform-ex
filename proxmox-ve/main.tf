provider "proxmox" {
  pm_api_url = "https://127.0.0.1:18006/api2/json"
}

resource "proxmox_vm_qemu" "proxmox-ubuntu" {
  count = var.instance_count
  vmid  = "${var.id+count.index}"
  name  = "ubuntu-${var.id+count.index}"
  desc  = "Ubuntu develop environment"
  # 节点名
  target_node = "pve"

  # cloud-init template
  clone      = "VM 1000"
  full_clone = true

  # storage= local-lvm
  cores   = 4
  sockets = 1
  # 内存
  memory = 4096


  agent   = 1
  os_type = "linux"
  onboot  = true
  # boot = "scsi0"


  network {
    model  = "virtio" # 网络设备类型
    bridge = "vmbr0"  # 桥接接口
  }

  ipconfig0 = "ip=${var.ips}.${var.id+count.index}/24,gw=${var.ips}.1"


  ciuser     = "root"
  cipassword = "123456"

}


variable "id" {
  description = "虚拟机的 ID"
  type        = number
  default     = 101
}

variable "instance_count" {
  type        = number
  default     = 5
  description = "description"
}

variable "ips" {
  type        = string
  default     = "192.168.144"
  description = "description"
}
