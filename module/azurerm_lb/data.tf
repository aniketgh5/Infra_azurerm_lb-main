data "azurerm_public_ip" "data_pip" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}
# data "azurerm_lb" "example" {
#   name                = "example-lb"
#   resource_group_name = "example-resources"
# }

# data "azurerm_lb_backend_address_pool" "data_lb_pool" {
#   name            = var.backendPool_name
#   loadbalancer_id = data.azurerm_lb.example.id
# }