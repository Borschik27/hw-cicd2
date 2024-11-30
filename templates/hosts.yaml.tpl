all:
  hosts:
%{ for vm_name, vm_data in vm_details }
    ${vm_name}:
      ansible_host: ${vm_data.network_interface[0].nat_ip_address}
      ansible_user: ${vm_user}
      ansible_port: 22
      ansible_connection: ssh
%{ endfor }