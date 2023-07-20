terraform {
  required_providers {

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.62.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.8.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "remote-state"
    storage_account_name = "devopsremotestate"
    container_name       = "remote-state"
    key                  = "pipeline-github-actions/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

data "terraform_remote_state" "vnet" {
  backend = "azurerm"
  config = {
    resource_group_name  = "remote-state"
    storage_account_name = "devopsremotestate"
    container_name       = "remote-state"
    key                  = "azure-vnet/terraform.tfstate"

  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owener     = "devops"
      managed-by = "terraform"
    }
  }
}
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "devops-udemy-remote-state"
    key    = "aws-vps/terraform.tfstate"
    region = "us-east-1"
  }
}

