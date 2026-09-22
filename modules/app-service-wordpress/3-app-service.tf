# ---------------------------------------------------------------------------
# App Service Plan - contains the WordPress web app
# ---------------------------------------------------------------------------
resource "azurerm_service_plan" "wordpress" {
  name                = "${var.prefix}-plan"
  resource_group_name = azurerm_resource_group.wordpress.name
  location            = azurerm_resource_group.wordpress.location
  os_type             = "Linux"
  sku_name            = "B1"
}

# ---------------------------------------------------------------------------
# App Service - deploys the WordPress custom container
# ---------------------------------------------------------------------------
resource "azurerm_linux_web_app" "wordpress" {
  name                = "${var.prefix}-wordpress"
  resource_group_name = azurerm_resource_group.wordpress.name
  location            = azurerm_service_plan.wordpress.location
  service_plan_id     = azurerm_service_plan.wordpress.id

  site_config {
    application_stack {
      # NOTE: We're using the WordPress image rather than the App Service WordPress
      # image because it's multi-architecture (meaning it works on arm64).
      docker_image_name   = "library/wordpress:latest"
      docker_registry_url = "https://index.docker.io"
    }
  }

  app_settings = {
    # Connect to MySQL
    "WORDPRESS_DB_HOST"     = azurerm_mysql_flexible_server.wordpress.fqdn
    "WORDPRESS_DB_NAME"     = azurerm_mysql_flexible_database.wordpress.name
    "WORDPRESS_DB_USER"     = azurerm_mysql_flexible_server.wordpress.administrator_login
    "WORDPRESS_DB_PASSWORD" = var.mysql_admin_password

    # Exposed by Apache within the container
    "WEBSITES_PORT"                       = "80"

    # Ensures that content is persisted across restarts
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "true"

    # Locally's MySQL emulator supports TLS (like Azure), so we need to tell WordPress
    # to connect over TLS - and we also need to tell it to handle HTTPS connections.
    "WORDPRESS_CONFIG_EXTRA" = "define('MYSQL_CLIENT_FLAGS', MYSQLI_CLIENT_SSL); if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') { $_SERVER['HTTPS'] = 'on'; }"
  }
}
