# Ansible Collection - kencx.ansible

This collection contains roles and playbooks for bootstrapping my homelab and
workstation.

## Roles
Refer to [docs/roles.md](https://github.com/kencx/ansible-collections/blob/master/docs/roles.md) for
documentation.

- `goss` installs and runs [Goss](https://github.com/aelsabbahy/goss) server validation
- `nfs` mounts given NFS shares
- `security` provides basic hardening such as configuring `sudo`, SSH hardening,
  installing ufw and fail2ban
- `ssl` generates TLS certificates from root and intermediate CAs
- `nginx` configures and starts nginx as systemd service
- `certbot` provisions Let's Encrypt certificates for given domains
- `webhook` configures and starts [webhook](https://github.com/adnanh/webhook) as systemd service

## Development
### Prerequisites
- ansible[lint]
- molecule[docker,vagrant]
- Docker
- Vagrant
- make

When testing locally, the collection can be quickly installed to the local
collections path with

```bash
$ make galaxy-install
```

### Molecule
To debug and test roles, run:

```bash
$ make converge scen=security
$ make verify scen=security
```

## Issues

When running roles with `service`, systemd is required. However,
[there](https://github.com/geerlingguy/docker-ubuntu2004-ansible/issues/18) are
[issues](https://github.com/ansible-community/molecule/discussions/3108) with
running systemd in Docker containers. As such, these roles require Vagrant and
molecule-vagrant. Affected roles:
- `security`

Additionally, `apt update` is not working well in Debian 10 container due to
"oldstable".
