terraform {
  backend "azurerm" {
    resource_group_name   = "rg-practice-dev"
    storage_account_name  = "sapracticedev"
    container_name        = "practicestate"
    key                   = "practice.terraform.tfstate"
  }
}
