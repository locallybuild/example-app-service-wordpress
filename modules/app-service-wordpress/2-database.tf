# ---------------------------------------------------------------------------
# Database - Azure Database for MySQL Flexible Server
#
# Stores the WordPress data. The dbformysql plugin launches a real MySQL
# container in Docker/Podman to back this server.
# ---------------------------------------------------------------------------
resource "azurerm_mysql_flexible_server" "wordpress" {
  name                   = "${var.prefix}-mysql"
  resource_group_name    = azurerm_resource_group.wordpress.name
  location               = azurerm_resource_group.wordpress.location
  administrator_login    = var.mysql_admin_login
  administrator_password = var.mysql_admin_password
  sku_name               = "B_Standard_B1ms"
  version                = "8.0.21"

  storage {
    size_gb = 20
  }
}

resource "azurerm_mysql_flexible_database" "wordpress" {
  name                = "wordpress"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.wordpress.name
  charset             = "utf8mb4"
  collation           = "utf8mb4_unicode_ci"
}
