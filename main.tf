# data "hcp_packer_image" "mssql-windows-2022" {
#   bucket_name    = "mssql-windows-2022"
#   channel        = "latest"
#   cloud_provider = "vsphere"
#   region         = "Datacenter"
# }


# module "vm" {
#   source  = "app.terraform.io/tfo-apj-demos/virtual-machine/vsphere"
#   version = "1.4.2"

#   template          = data.hcp_packer_image.mssql-windows-2022.cloud_image_id
#   hostname          = var.hostname
#   num_cpus          = local.sizes[var.size].cpu
#   memory            = local.sizes[var.size].memory
#   cluster           = local.environments[var.environment]
#   datacenter        = local.sites[var.site]
#   primary_datastore = local.storage_profile[var.storage_profile]
#   resource_pool     = local.tiers[var.tier]

#   tags = {
#     environment      = var.environment
#     site             = var.site
#     backup_policy    = var.backup_policy
#     tier             = var.tier
#     storage_profile  = var.storage_profile
#     security_profile = var.security_profile
#   }
  
#   folder_path = var.folder_path
#   disk_0_size = 100

#   networks = {
#     "seg-general" = "dhcp"
#   }

#   userdata = templatefile("${path.module}/templates/userdata.yaml.tmpl", {
#     custom_text = var.custom_text
#     hostname    = var.hostname
#   })

#   metadata = templatefile("${path.module}/templates/metadata.yaml.tmpl", {
#     dhcp     = true
#     hostname = var.hostname
#   })
# }

module "single_virtual_machine" {
  for_each = var.vm_config
  source   = "app.terraform.io/tfo-apj-demos/single-virtual-machine/vsphere"
  version  = "~> 1.3"

  hostname           = each.value.hostname
  ad_domain          = each.value.ad_domain
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