{ config, pkgs, inputs, ... }:

{

  imports = [ 
    inputs.spicetify-nix.homeManagerModules.default
    ./modules/apps/browser.nix
    ./modules/home/fastfetch.nix
    ./modules/home/kitty.nix
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
      eduroam = "geteduroam-gui";
      sklauncher = "steam-run java -jar ~/SKlauncher.jar";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };
  
  home.packages = with pkgs; [
    kitty
    fastfetch
    vesktop
  ];

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "mauve";
    cava.enable = true;
    cava.flavor = "frappe";
  };

  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.spicetify = {
    enable = true;

    wayland = true;
    windowManagerPatch = false;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.retroBlur;
    colorScheme = "purple";

    experimentalFeatures = null;
    alwaysEnableDevTools = false;
  };
}