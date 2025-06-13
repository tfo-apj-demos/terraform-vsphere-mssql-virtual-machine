output "virtual_machine_id" {
  description = "The ID of the virtual machine."
  value       = module.single_virtual_machine.virtual_machine_id
}

output "vsphere_compute_cluster_id" {
  description = "The ID of the vSphere compute cluster where the VM is deployed."
  value       = module.single_virtual_machine.vsphere_compute_cluster_id
}

output "virtual_machine_name" {
  description = "The name of the virtual machine."
  value       = module.single_virtual_machine.virtual_machine_name
}

output "ip_address" {
  description = "The default IP address of the virtual machine."
  value       = module.single_virtual_machine.ip_address
}
