module "single_virtual_machine" {
  for_each = var.vm_config
  source   = "app.terraform.io/tfo-apj-demos/single-virtual-machine/vsphere"
  version  = "~> 1.3"

  hostname           = each.value.hostname
  ad_domain          = each.value.ad_domain
  domain_admin_user     = var.domain_admin_user
  domain_admin_password = var.domain_admin_password
  backup_policy      = each.value.backup_policy
  environment        = each.value.environment
  os_type            = each.value.os_type
  linux_distribution = each.value.linux_distribution
  security_profile   = each.value.security_profile
  site               = each.value.site
  size               = each.value.size
  storage_profile    = each.value.storage_profile
  tier               = each.value.tier
}

resource "aap_inventory" "vm_inventory" {

  name        = "Better Together Demo - ${var.TFC_WORKSPACE_ID}"
  description = "Inventory for VMs built with HCP Terraform and managed by AAP"
}

resource "aap_group" "sql_group" {
  inventory_id = aap_inventory.vm_inventory.id
  name         = "windows_servers"
}

resource "aap_host" "vm_host" {
  for_each     = var.vm_config
  inventory_id = aap_inventory.vm_inventory.id
  name         = module.single_virtual_machine[each.key].virtual_machine_name
  groups       = [aap_group.sql_group.id]
  
  variables = jsonencode({
    ansible_host    = module.single_virtual_machine[each.key].ip_address
    ansible_host       = module.single_virtual_machine[each.key].ip_address
    ansible_connection = "ssh"
    ansible_port       = 22
    ansible_shell_type = "powershell"
  })
}