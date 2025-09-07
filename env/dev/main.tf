module "resource_group" {
    source = "../../module/azurerm_resource_group"
    rg_name = "elearn_rg"
    rg_location = "centralindia"
}

module "azurerm_virtual_network" {
    source = "../../module/azurerm_virtual_network"
    depends_on = [ module.resource_group ]
    vnet_name = "elearn_vnet"
    vnet_location = "centralindia"
    rg_name = "elearn_rg"
    address_space = ["10.0.0.0/16"]
}

module "subnet" {
    source = "../../module/azurerm_subnet"
    depends_on = [ module.azurerm_virtual_network ]
    subnet_name = "elearn_subnet"
    vnet_name = "elearn_vnet"
    rg_name = "elearn_rg"
    address_prefixes = ["10.0.1.0/24"]
}

module "public_ip" {
    source = "../../module/azurrerm_public_ip"
    depends_on = [ module.resource_group ]
    pip_name = "elearn_lb_pip"
    rg_name = "elearn_rg"
    pip_location = "centralindia"
    allocation_method = "Static" 
}

module "nic" {
    source = "../../module/azurerm_network_interface_card"
    depends_on = [ module.subnet ]
    nic_name = "elearn_nic"
    nic_location = "centralindia"
    rg_name = "elearn_rg"
    vnet_name = "elearn_vnet"
    subnet_name = "elearn_subnet"
}

module "vm" {
  source = "../../module/azurerm_virtual_machine"
  depends_on = [ module.nic ]
  vm_name = "elearnvm"
  vm_location = "centralindia"
  rg_name = "elearn_rg"
  admin_username = "elearnuser"
  admin_password = "Password@123"
  nic_name = "elearn_nic"
}

module "lb" {
    source = "../../module/azurerm_lb"
    depends_on = [ module.public_ip ,module.resource_group]
    lb_name = "elearn_lb"
    lb_location = "centralindia"
    rg_name = "elearn_rg"
    frontend_ipconfig = "lb_ip"
    pip_name = "elearn_lb_pip"
    backendPool_name = "lb_pool"
    probe_name = "lb_probe"
    lb_rule_name = "lb_rule"
  
}

module "nic_association" {
    source = "../../module/nic_association"
    depends_on = [ module.nic , module.lb ,module.resource_group , module.nsg ]
    nic_name = "elearn_nic"
    rg_name = "elearn_rg"
    backendPool_name = "lb_pool"
    lb_name = "elearn_lb"
    nsg_name = "elearn_nsg"
  
}

module "nsg" {
    source = "../../module/azurerm_network_security_group"
    depends_on = [ module.resource_group ]
    nsg_name = "elearn_nsg"
    nsg_location = "centralindia"
    rg_name = "elearn_rg"
  
}