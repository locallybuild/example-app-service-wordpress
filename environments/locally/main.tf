provider "azurerm" {
  features {}
}

module "app-service-wordpress" {
  source = "../../modules/app-service-wordpress"

  prefix               = "locally-demo"
  location             = "berlin"
  mysql_admin_login    = "wpadmin"
  mysql_admin_password = "Wordpress-Local-123"
  tags = {
    ProvisionedBy = "Terraform"
  }

  providers = {
    azurerm = azurerm
  }
}

output "wordpress_url" {
  value = module.app-service-wordpress.wordpress_default_hostname
}
