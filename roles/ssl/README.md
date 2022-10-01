## ssl

This role generates a private key and certificate pair for TLS. It can optionally create
a root CA and intermediate CA on localhost, or you may supply your own CA certificates
for signing.

A local `certs` directory is created to fetch the remotely created CSR for signing.
Then, the newly signed certificate and given CA chain file is pushed to the remote host
and the remote trust store is updated.

| Variable | Description | Default |
| -------- | ----------- | ------- |
| ssl_ca_dir | Parent directory of root and intermediate CA | `/root` |
| ssl_create_root_ca | Create a new root CA | true |
| ssl_root_ca_dir | Holding directory for root CA files | `{{ ssl_ca_dir }}/ownca/root` |
| ssl_root_ca_key | Root CA private key name | `ca_key.pem` |
| ssl_root_ca_cert | Root CA certificate name | `ca.crt` |
| ssl_create_intermediate_ca | Create a new intermediate CA | true |
| ssl_intermediate_ca_dir | Holding directory for intermediate CA files | `{{ ssl_ca_dir }}/ownca/intermediate` |
| ssl_intermediate_ca_key | Intermediate CA private key name | `intermediate_key.pem` |
| ssl_intermediate_ca_cert | Intermediate CA certificate name | `intermediate.crt` |
| ssl_cert_dir | Holding directory for signing certs | `/tmp/certs` |
| ssl_ca_chain_file | Provided CA chain file | `{{ ssl_cert_dir }}/ca-chain.crt` |
| ssl_remote_user | Remote host user to become | `debian` |
| ssl_remote_tls_dir | Remote holding directory for TLS files | `~/tls` |
| ssl_remote_ca_trust_store_dir | CA trust store directory | `/usr/share/ca-certificates/ownca` |
| ssl_remote_cert_name | Name of signed certificate | `{{ ssl_remote_user }}` |
| ssl_remote_cert_common_name | Common name of signed cert | `example.com` |
| ssl_remote_cert_subject_alt_name | SAN of signed cert | `DNS:example.com` |
| ssl_remote_cert_ttl | TTL of signed cert | `+365d` |

#### Notes

- When creating a new root or intermediate CA, local root permissions are required.
- When providing your own intermediate CA for signing, ensure it is readable by the
	local Ansible user. You might be required to use `-K` and pass sudo password if necessary.
- When providing your own CA chain file, ensure it is world-readable or at least
	readable by your local Ansible user.
- This role only supports updating of certificate trust store on Ubuntu/Debian systems.
