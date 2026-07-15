### Переменные для web-ВМ

variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Name of the web VM"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID for web VM"
}

#variable "vm_web_cores" {
#  type        = number
#  default     = 2
# description = "CPU cores for web VM"
#}

#variable "vm_web_memory" {
#  type        = number
#  default     = 2
#  description = "RAM size in GB for web VM"
#}

#variable "vm_web_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Guaranteed vCPU fraction for web VM"
#}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Is web VM preemptible"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Provide NAT for web VM"
}

variable "vm_web_family_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family for web VM"
}


### Переменные для db-ВМ

variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "Name of the db VM"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID for db VM"
}

#variable "vm_db_cores" {
#  type        = number
#  default     = 2
#  description = "CPU cores for db VM"
#}

#variable "vm_db_memory" {
#  type        = number
#  default     = 2
#  description = "RAM size in GB for db VM"
#}

#variable "vm_db_core_fraction" {
#  type        = number
#  default     = 20
#  description = "Guaranteed vCPU fraction for db VM"
#}

variable "vm_db_preemptible" {
  type        = bool
  default     = true
  description = "Is db VM preemptible"
}

variable "vm_db_nat" {
  type        = bool
  default     = true
  description = "Provide NAT for db VM"
}

variable "vm_db_family_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS image family for db VM"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "Zone for db VM"
}

### Новая map-переменная для ресурсов ВМ
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  default = {
    web = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 5
      hdd_type      = "network-hdd"
    }
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 5
      hdd_type      = "network-hdd"
    }
  }
}

variable "vm_metadata" {
  type = map(string)
  default = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:ssh-ed25519 AAAA"
  }
  description = "Metadata for all VMs"
}
