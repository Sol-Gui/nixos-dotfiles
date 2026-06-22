{ config, pkgs, inputs, ... }:

{

  imports = [ 
    inputs.spicetify-nix.homeManagerModules.default
  ];

  home.username = "gui";
  home.homeDirectory = "/home/gui";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo I use nixos, btw";
      roblox = "flatpak run org.vinegarhq.Sober";
      steam = "DISPLAY=:1 steam";
    };
  };
  
  home.packages = with pkgs; [
    vesktop
  ];

  programs.spicetify = {
    enable = true;
    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.catppuccin;
    colorScheme = "mocha";
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions; [
      fullAppDisplay
      shuffle
    ];
  };
}
