resource "azurerm_resource_group" "rg" {
  name     = "${terraform.workspace}-rg"
  location = var.location
}

module "network" {
  source   = "./modules/network"
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  env      = terraform.workspace
}
module "linux_vm" {
  source    = "./modules/linux-vm"
  rg_name   = azurerm_resource_group.rg.name
  location  = var.location
  subnet_id = module.network.subnet_id
  env       = terraform.workspace
  vm_size   = "Standard_B2s"
}
