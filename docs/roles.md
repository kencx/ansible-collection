# Roles Documentation

## Ansible
The `ansible` role installs pip, pipx, Ansible and ansible-lint.

| Variable   | Description    | Default |
|--------------- | --------------- | ---------|
| user | User to install Ansible | `debian` |

## Goss
The `goss` role installs the Goss binary and runs a given Goss file. Rendering of
multiple Goss files is supported.

| Variable   | Description    | Default |
|--------------- | --------------- | ---------|
| goss_version   | Version of Goss to install | `v0.3.18` |
| goss_binary_path | Path to install Goss binary | `/bin/goss` |
| goss_dir   | Local Goss directory that contains all Goss files to run. This directory will be copied to the remote host | `files` |
| goss_parent_dir | Remote parent directory to copy `goss_dir` to | `/tmp` |
| goss_file | Goss file in `goss_dir` to run | `goss.yml` |
| remove_goss_binary | Remove Goss binary after running role | `false` |

Single file: With the above defaults, the local `files/goss.yml` is copied to the remote
`/tmp/goss/goss.yml` and ran.

Multiple files: When a custom `goss_dir` is given with multiple goss
files, all contents in `goss_dir` will be copied to the remote `/tmp/goss_dir` and
the user can specify the parent `/tmp/goss_dir/goss_file` that will be rendered and used for
validation.

## NFS

Installs nfs-common package and mounts defined NFS shares.

| Variable   | Description    | Default |
|--------------- | --------------- | ---------|
| nfs_opts | NFS Options | `rw,sync,hard,intr,bg,nofail` |
| nfs_share_mounts | List of NFS shares | `[]` |

Example:
```yaml
nfs_share_mounts:
  - src: "10.10.10.100:/mnt/example"
    path: "/mnt/example"
    state: mounted
```

## Security
Basic security hardening on Linux systems including:

- Add groups to sudoers
- SSH hardening
- Add Fail2ban
- Configure ufw firewall

| Variable   | Description    | Default |
|--------------- | --------------- | ---------|
| ssh_port | SSH port | `22` |
| ssh_disable_root_login | Disable root login for SSH | `true` |
| ssh_disable_password_auth | Disable password authentication for SSH | `true` |
| ssh_disable_gateway_ports | Disable gateway ports for SSH | `true` |
| ssh_login_grace_time | Set login grace time for SSH | `30` |
| ssh_max_auth_tries | Set max authentication tries for SSH | `3` |
| ssh_max_sessions | Set max number of sessions for SSH | `3` |
| ssh_max_startups | Set max number of startups for SSH | `3` |
| sudoers | List of groups to add sudo privileges | `[sudo]` |
| ufw_rules | List of ufw rules to add. Requires port, proto and rule | `[]` |
| fail2ban_config_file | Config file for fail2ban | `jail.local.j2` |
| skip_handlers | Skip restarting services | `false` |

## SSL

This role generates a private key and certificate pair for TLS. It can optionally create
a root CA and intermediate CA on localhost, or you may supply your own CA certificates
for signing.

A local `certs` directory is created to fetch the remotely created CSR for signing.
Then, the newly signed certificate and given CA chain file is pushed to the remote host
and the remote trust store is updated.

| Variable | Description | Default |
| -------- | ----------- | ------- |
| ssl_ca_dir | Parent directory of root and intermediate CA | `/root` |
| ssl_create_root_ca | Create a new root CA | `true` |
| ssl_root_ca_dir | Holding directory for root CA files | `{{ ssl_ca_dir }}/ownca/root` |
| ssl_root_ca_key | Root CA private key name | `ca_key.pem` |
| ssl_root_ca_cert | Root CA certificate name | `ca.crt` |
| ssl_create_intermediate_ca | Create a new intermediate CA | `true` |
| ssl_intermediate_ca_dir | Holding directory for intermediate CA files | `{{ ssl_ca_dir }}/ownca/intermediate` |
| ssl_intermediate_ca_key | Intermediate CA private key name | `intermediate_key.pem` |
| ssl_intermediate_ca_cert | Intermediate CA certificate name | `intermediate.crt` |
| ssl_cert_dir | Holding directory for signing certs | `/tmp/certs` |
| ssl_create_cert_chain | Create a cert chain | `true` |
| ssl_ca_chain_name | Local and remote cert chain file name | `ca-chain` |
| ssl_ca_chain_path | Local provided CA chain filepath | `{{ ssl_cert_dir }}/{{ ssl_ca_chain_name }}.crt` |
| ssl_remote_user | Remote host user to become | `debian` |
| ssl_remote_tls_dir | Remote holding directory for TLS files | `~/tls` |
| ssl_remote_ca_trust_store_dir | CA trust store directory | `/usr/share/ca-certificates/ownca` |
| ssl_remote_cert_name | Name of signed certificate | `{{ ssl_remote_user }}` |
| ssl_remote_cert_common_name | Common name of signed cert | `example.com` |
| ssl_remote_cert_default_san | Default SAN(s) of signed cert | `[DNS:{{ ansible_host }}, DNS:{{ ansible_fqdn }}, IP:127.0.0.1]` |
| ssl_remote_cert_san | SAN(s) of signed cert | `[DNS:example.com]` |
| ssl_remote_cert_ttl | TTL of signed cert | `+365d` |

#### Notes

- When creating a new root or intermediate CA, local root permissions are required.
- If `ssl_create_root_ca` or `ssl_create_intermediate_ca` is false, you must provide a
  valid root/intermediate key pair in `ssl_root_ca_dir` or `ssl_intermediate_ca_dir`
  respectively.
- When providing your own intermediate CA for signing, ensure it is readable by the
  local Ansible user. You might be required to use `-K` and pass sudo password if
  necessary.
- If `ssl_create_cert_chain: false`, you **must** provide your own CA chain file. It can
  be referenced with `ssl_ca_chain_name` and `ssl_ca_chain_path`. Ensure it is
  world-readable or at least readable by your local Ansible user.
- This role only supports updating of certificate trust store on Ubuntu/Debian systems.

## Terraform

Installs Hashicorp Terraform if not already installed.


| Variable   | Description    | Default |
|--------------- | --------------- | ---------|
| latest_terraform_version | Latest version | `1.1.7` |
| terraform_os | Operating system | `linux` |
| terraform_arch | Architecture | `amd64` |
