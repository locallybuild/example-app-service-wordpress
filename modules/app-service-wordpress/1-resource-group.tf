# ---------------------------------------------------------------------------
# Resource Group - which contains the deployed resources
# ---------------------------------------------------------------------------
resource "azurerm_resource_group" "wordpress" {
  name     = "${var.prefix}-resources"
  location = var.location
  tags     = var.tags
}
