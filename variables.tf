variable "proxmox_url" {
  type        = string
  sensitive   = true
  description = "The API URL for Proxmox, ending with `/api2/json`"
}

variable "proxmox_tls_insecure" {
  type    = bool
  default = true
}

variable "server_friendly_name" {
  type    = string
  default = "durban"
}

variable "proxmox_target_node" {
  type    = string
  default = "proxmox"
}

variable "k3os_version" {
  type    = string
  default = "v0.21.5-k3s2r0"
}

variable "ipxe_host" {
  type = string
}

variable "ipxe_username" {
  type = string
}

variable "ipxe_password" {
  type = string
}

variable "dns_servers" {
  type      = list(string)
  sensitive = true
}

variable "node_token" {
  type      = string
  default   = ""
  sensitive = true
}

variable "server_url" {
  type      = string
  sensitive = true
}

variable "additional_ssh_keys" {
  type    = list(string)
  default = []
}
