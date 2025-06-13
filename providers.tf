terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.77"
    }
    aap = {
      source  = "ansible/aap"
      version = "~> 1.2"
    }
  }
}

provider "aap" {
}