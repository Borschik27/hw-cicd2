######For vms_platform
output "vm_details" {
  description = "Details for each VM"
  
  value = {
    for vm_name, vm_data in yandex_compute_instance.vm : vm_name => {
      name    = vm_data.name
      hostname = vm_data.hostname
      ip      = vm_data.network_interface[0].nat_ip_address
      metadata = vm_data.metadata
    }
  }
}

output "db_private_ip" {
  description = "Private IP of the Postgres VM"
  value       = yandex_compute_instance.vm["postgres"].network_interface[0].ip_address
}