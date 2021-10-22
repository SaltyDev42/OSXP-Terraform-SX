#cloud-config
## THIS THING UP HERE IS A SHEBANG?
groups:
  - ${name}

# Add users to the system. Users are added after groups are added.
users:
  - ssh_authorized_keys:
      - ${awxpubkey}
  - name: ${name}
    gecos: ${name}
    shell: /bin/bash
    primary_group: ${name}
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, wheel, root
    lock_passwd: false
    ssh_authorized_keys:
      - ${pubkey}

prefer_fqdn_over_hostname: true
hostname: ${name}
fqdn: ${name}.${domain}
