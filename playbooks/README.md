
### dotfiles

These tasks clone my dotfiles git repo and applies the configuration with `stow`.
It also adds desktop entries for use with `rofi`.

The role has 2 modes: `full` which adds all configuration, while `minimal` adds
a minimal set of configuration for use in remote servers.

Default variables:
```yaml
full: true
dotfiles_repo_url: [my dotfiles repo](https://github.com/kencx/dotfiles)
dotfiles_repo_path: "~/dotfiles"

minimal: false
```

### ricing

This task list adds ricing to the system:
- Changing wallpaper
- Installs packaged rice apps
- Installs and applies fonts
- Adds custom firefox config and startpage (if firefox is installed)

Default variables:
```yaml
apps: [bspwm, sxhkd, dunst, rofi, feh, scrot]

font_repo_url: [nerd-font repo]
font_version: v2.1.0
font_name: FiraCode
font_dir: "~/.local/share/fonts"

firefox_path: "~/.mozilla"
startpage_url: "[startpage repo](https://github.com/kencx/startpage)"
startpage_dest: "~/.mozilla/startpage"
```

Although the startpage repo is added, the user must manually set the startpage
in Firefox - `settings -> home -> new windows and tabs`
>Edit: firefox needs to be started for the first time before `~/.mozilla` is
>created.

>NOTE: `xfce-notifyd` is removed in favour of `dunst`.

### apps directory

The `apps/` folder contains roles for installing applications that require
compilation or unarchiving from their git repos (ie. cannot be installed from `package`).

Although some of these programs can be installed from `apt` package manager,
they are not the most updated versions. Hence, the need for these roles.

However, these roles are difficult to maintain as they are dependent on the
following, which are suspectible to change:
- Git repo url
- Release tar package url
- Compilation and build instructions changes

I hope to move away from this when I start to support Arch installations with
`pacman`.

>**TODO**:
>- Ensure all apps check for installed versions and files before continuing.
>- Remove build dependencies and directories upon successful installation
>- Support updates
