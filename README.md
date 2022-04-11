# Ansible Collection - kencx.ansible

This collection contains roles and playbooks for bootstrapping my homelab and
workstation.

## Roles
- `security` provides basic hardening such as configuring `sudo`, SSH hardening,
  installing ufw and fail2ban
- `terraform` installs Terraform CLI
- `python3` installs and updates Python3 and pip3

## Playbooks
Bootstraps a brand new development workstation. Tested on Ubuntu 21.04.

Refer to `playbooks` for more details.

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

## TODO
- [ ] `group_vars`
- [ ] precommit
- [ ] CI/CD
- [ ] molecule scenario for `binaries`
