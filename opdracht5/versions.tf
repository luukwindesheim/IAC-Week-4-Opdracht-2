terraform {
  required_version = ">= 1.5.0"

  required_providers {
    esxi = {
      source  = "josenk/esxi"
      version = "~> 1.9"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}
