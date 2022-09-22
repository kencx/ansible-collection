# Roles Documentation

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
