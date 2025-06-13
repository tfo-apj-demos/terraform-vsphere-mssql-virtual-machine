# This file contains the configuration for the virtual machines.
# It defines the properties for each VM, including hostname, domain, backup policy, environment, OS type, distribution, security profile, site, size, storage profile, and tier.
vm_config = {
  db-server = {
    hostname           = "mssql-server-01"
    os_type            = "mssql"
    linux_distribution = ""
    site               = "sydney"
    size               = "large"
    security_profile   = "db-server"
    environment        = "dev"
    ad_domain          = "hashicorp.local"
    backup_policy      = "daily"
    storage_profile    = "standard"
    tier               = "gold"
  }
}