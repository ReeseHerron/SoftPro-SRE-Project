output "web_server_ip" {
  description = "The public IP address of the web server"
  value       = module.networking.public_ip_address
}
