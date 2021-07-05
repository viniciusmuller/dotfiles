<h1 align="center">My linux dotfiles</h1>

# Installation

## Nixos
```bash
git clone https://github.com/arcticlimer/dotfiles
sudo nixos-rebuild switch --flake dotfiles#nixos
```

# Structure
- `.vim` -> Old dotfiles that will be translated into nix.
- `.config` -> Old dotfiles that will be translated into nix.
- `pkgs` -> Packages for home-manager.
- `nixos-pkgs` -> Packages from the `pkgs` wrapped to work with nixos (E.g: Adds the "docker" group to an user)
- `desktop` -> Wrappers around `pkgs` to build different desktop environments.
- `services` -> Home-manager services.
- `profiles` -> Things such as different development environments.
- `machines` -> My configurations for different machines
- `utils` -> Useful scripts.
