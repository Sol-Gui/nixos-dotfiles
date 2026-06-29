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
    };
  };
  
  home.packages = with pkgs; [
    kitty
    fastfetch
    vesktop
  ];

  programs.spicetify = {
    enable = true;

    wayland = true;
    windowManagerPatch = false;

    theme = inputs.spicetify-nix.legacyPackages.${pkgs.system}.themes.retroBlur;
    colorScheme = "purple";

    enabledExtensions =
      with inputs.spicetify-nix.legacyPackages.${pkgs.system}.extensions;
      [
        coverAmbience
        catJamSynced
        fullAppDisplayMod
        spicyLyrics
        playlistIcons
        focusMode
        sideHide
        showQueueDuration
        volumePercentage
        sleepTimer
        history
        sessionStats
      ];

    experimentalFeatures = null;
    alwaysEnableDevTools = false;
  };
}
