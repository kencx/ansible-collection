# binaries

This role downloads and installs tar binaries from a given url. It accepts a
list of programs with their corresponding `url, dest and wildcard`.

Default variables:
```yaml
binary_url: "[fzf-url]"          # tar file url
binary_dest: `$HOME/.local/bin`  # destination to put binary
wildcard: ""                     # wildcard for binary name
opts: ""                         # extra options for tar
```

>NOTE: `wildcard` is necessary for tar files that come with other documents or
>manpages that may be unwanted in the bin folder. It is also use together with
>`opts` for instances when the package must be stripped from its parent folder.
>In such cases, the wildcard must specify the full parent dir as well.

Refer to `group_vars/workstation.yml` for examples on the variables that can be
passed. By default, this role installs `fzf v0.29.0`.

>**TODO**:
>- Remove dependence on parent dir.
>- Add check for installed file and version
