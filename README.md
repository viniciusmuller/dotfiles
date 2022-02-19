<h1 align="center">❄️ My Nix/NixOS Dotfiles</h1>

# Installation

## NixOS
```bash
git clone https://github.com/arcticlimer/dotfiles
sudo nixos-rebuild switch --flake ./dotfiles#<configName>
```
## Non-NixOS using home-manager
```bash
# Note: It requires nixUnstable and `experimental-features = nix-command flakes`
git clone https://github.com/arcticlimer/dotfiles
nix build ".#homeConfigurations.<configName>.activationPackage" && ./result/activate
```

# Structure
- `pkgs` -> Packages for home-manager.
- `nixos-pkgs` -> Packages from the `pkgs` directory wrapped to work with NixOS (E.g: Adds the "docker" group to an user).
- `nixos-services` -> Services wrapped to work with NixOS.
- `desktop` -> Wrappers around `pkgs` to build different desktop environments.
- `services` -> Home-manager services.
- `profiles` -> Things such as different development environments.
- `hosts` -> My configurations for different machines
- `home-configurations` -> Home-manager configurations.
- `utils` -> Useful scripts.
- `templates` -> Template flakes for different kinds of projects.
