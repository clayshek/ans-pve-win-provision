# ans-pve-win-provision

## Summary

Ansible playbook to provision new Windows VM(s), cloned off of an existing template on a [Proxmox](https://www.proxmox.com/en/proxmox-ve) hypervisor. Mostly custom to my lab environment, but easy enough to modify.

As exists currently in this repo, will create the following new VMs in Proxmox:
- DC01 & DC02 (base VMs for Active Directory Domain Controllers)
- SCVMM01 (base VM for System Center Virtual Machine Manager)
- WAC01 (base VM for Windows Admin Center)
- HVH01, HVH02, HVH03, HVH04 (base VMs for Hyper-V Hypervisor nodes, requires Proxmox nested virtualization)

This allows for per-VM customization of parameters such as name, IP, CPU, RAM, admin password, and adding an additional data drive. 

End result will be running VM(s) based off of specified template, which are ready to be further customized (domain join, role/feature and application installation) - see https://github.com/clayshek/ansible-lab-config

## Usage & Requirements

- Requires a Windows template to already exist (see https://github.com/clayshek/ans-pve-win-templ)
- Modify inventory.yml if necessary. Any new hosts will need to have a hostname.yml variables file created in host_vars/
- Modify variables in group_vars and host_vars as necessary. Consider [Ansible Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) for passwords / sensitive variables.
- Fail / Retry logic added to account for per-node file locks, and is expected (see To-Do section)

`ansible-playbook -i inventory.yml --ask-vault-pass provision-base-vms.yml`

- Or to limit to a specific host or host group:

`ansible-playbook -i inventory.yml -l [HOST|HOSTGROUP] --ask-vault-pass provision-base-vms.yml`

Once VM / OS provisioning complete, detach and delete the ISO created with the unattend.xml file (this will have cleartext administrator credentials).

## To-Do

 - [ ] Add functionality to detach CDROM from VM and delete unattend ISO when provisioning complete
 - [ ] Possibly change VM creation to run serially as opposed to parallel to prevent file locks

## Disclaimer

Primary purpose is to quickly provision base VMs for a Windows infrastructure lab environment on top of Proxmox. Security best practices not always a top priority. 