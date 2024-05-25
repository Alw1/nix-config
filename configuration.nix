{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./sway-configuration.nix
    ];


  #garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  #enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nix"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  programs = {
    zsh = {
	    enable = true;
	    enableCompletion = true;
	    autosuggestions.enable = true;
	    shellAliases = {
	      nix-upgrade = ''sudo nixos-rebuild switch --flake ~/nixos-config'';
	    };
    };

    firefox.enable = true;

    steam = {
	    enable = true;
    	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };	
  };

  users.users.alex = {
    isNormalUser = true;
    description = "Alex Wyatt";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];  
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #Progrmaming stuff
    neovim
    vim
    gcc	
    gnumake
    python3	
    rustc
    go
    ghc 
    jdk
    git
    vscode

    #Personal stuff
    spotify
    discord
    melonDS

    #System stuff 
    gtk-engine-murrine
    nerdfonts
    
    #CLI utilities
    fastfetch
    nitch
    zip
    unzip
    silver-searcher
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
