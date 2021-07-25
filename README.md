<h1 align="center">My linux dotfiles</h1>

# Installation

## Nixos
```bash
git clone https://github.com/arcticlimer/dotfiles
sudo nixos-rebuild switch --flake ./dotfiles#nixos
```
## Non-nixos using home-manager
```bash
# Note: It requires nixUnstable and `experimental-features = nix-command flakes`
git clone https://github.com/arcticlimer/dotfiles
home-manager switch --flake ./dotfiles#<configName>
```

You can check the Neovim keybindings [here](./pkgs/nvim/README.md)

# Structure
- `.vim` -> Old dotfiles that will be translated into nix.
- `.config` -> Old dotfiles that will be translated into nix.
- `pkgs` -> Packages for home-manager.
- `nixos-pkgs` -> Packages from the `pkgs` directory wrapped to work with nixos (E.g: Adds the "docker" group to an user)
- `desktop` -> Wrappers around `pkgs` to build different desktop environments.
- `services` -> Home-manager services.
- `profiles` -> Things such as different development environments.
- `hosts` -> My configurations for different machines
- `utils` -> Useful scripts.
