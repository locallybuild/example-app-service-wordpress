output "wordpress_default_hostname" {
  description = "The default hostname for the Wordpress site."
  value       = "https://${azurerm_linux_web_app.wordpress.default_hostname}"
}
