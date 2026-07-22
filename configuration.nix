{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;

    minegrub-world-sel = {
      enable = true;

      customIcons = with config.system; [
        {
          inherit name;
          lineTop = with nixos; distroName + " " + codeName + " (" + version + ")";
          lineBottom = "Survival Mode, No Cheats, Version: " + nixos.release;
          imgName = "nixos";
        }
      ];
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  networking.hostName = "nixos-btw"; # Define your hostname.
  networking.networkmanager.enable = true;
  
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  nixpkgs.config.allowUnfree = true;
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;    
  };

  swapDevices = [
  {
    device = "/swapfile";
    size = 10 * 1024; # 10 GB
  }
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  time.timeZone = "America/Sao_Paulo";


  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  services.xserver.xkb = {
    layout = "br";
    variant = "abnt2";
  };

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    videoDrivers = [ "amdgpu" ];
    #windowManager.qtile.enable = true;
  };

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;

  systemd.user.services.pipewire-pulse = {
    wantedBy = [ "default.target" ];
    serviceConfig.SystemCallFilter = [ "" ];
  };
 
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config.common.default = "*";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gui = {
    isNormalUser = true;
    extraGroups = [ 
      "wheel"
      "networkmanager"
      "bluetooth"
      "video"
      "audio"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.niri.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.nix-ld = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    (jdk21.override {
      enableJavaFX = true;
    })

    (sddm-astronaut.override {
      embeddedTheme = "black_hole";
    })

    kdePackages.okular
    ollama
    obsidian

    libXxf86vm
    libX11
    libXext
    libXi
    libXrandr
    libXcursor
    libXrender
    libxcb

    libGL
    openal

    vim
    neovim
    insomnia
    vscode
    codex

    mpv
    mpvpaper
    waypaper
    cava
    geteduroam
    nautilus
    ani-cli
    git
    fastfetch
    vesktop
    proton-vpn
    steam-run
    
    xwayland
    xwayland-satellite
    wireguard-tools
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default  
  ];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";

    extraPackages = [
      pkgs.kdePackages.qtmultimedia
    ];
  };

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "Sol-Gui";
      user.email = "int.guimarques@gmail.com";
    };
  };

  networking.firewall.checkReversePath = false;

  services.gnome.gnome-keyring.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}

