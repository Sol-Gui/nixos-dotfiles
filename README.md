# nixos-dotfiles

## Instalando em uma máquina nova

1. Clonar o repositório
   `git clone git@github.com:Sol-Gui/nixos-dotfiles.git ~/nixos-dotfiles`

2. Substituir o hardware-configuration.nix pelo da nova máquina
   `nixos-generate-config --show-hardware-config > ~/nixos-dotfiles/hardware-configuration.nix`

3. Aplicar
   `sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-btw`