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

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Bootloader.
#  boot.loader.systemd-boot.enable = true;
#  boot.loader.efi.canTouchEfiVariables = true;
  
#  boot.loader = {
#	systemd-boot.enable = true;
#	efi.canTouchEfiVariables = true;
# };

    boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/"; # ← use the same mount point here.
        };
        grub = {
            enable = true;
            efiSupport = true;
            #efiInstallAsRemovable = true;
            device = "nodev";
        };
    };

  networking.hostName = "nix"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = false; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Display Manager
  services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
  };


  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
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

 #Services for laptop battery optimization
 services.power-profiles-daemon.enable = false;
 services.tlp = {
    enable = true;
 }; 
 
 services.thermald.enable = true;


  programs = {
    zsh = {
	    enable = true;
	    enableCompletion = true;
	    autosuggestions.enable = true;
	    shellAliases = {
	      nixos-upgrade = ''nix flake upgrade --flake ~/nixos-config && sudo nixos-rebuild switch --flake ~/nixos-config'';
#	      config = ''/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'';
	    };
    };

    firefox.enable = true;

    steam = {
	    enable = true;
    	remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
	    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };	
  };

 users.defaultUserShell = pkgs.zsh;

  users.users.alex = {
    isNormalUser = true;
    description = "Alex Wyatt";
    extraGroups = [ "networkmanager" "wheel" ];  
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    #Programming stuff
    neovim
    vim
    gcc	
    gnumake
    python3	
    go 
    ghc
    cabal-install
    jdk
    git
    vscode
    libreoffice

    #Personal stuff
    spotify
    discord
    melonDS

    #System stuff 
    gtk-engine-murrine
    nixos-icons
    gruvbox-gtk-theme
    xz
    pkg-config 
    gmp
    ncurses
    zlib
    ripgrep

    #CLI utilities
    nitch
    zip
    unzip
    ranger
    gotop
    silver-searcher
  ];


  fonts.packages = with pkgs; [
    intel-one-mono 
    monocraft
    nerdfonts
    font-awesome
  ];

  #NOTE: Never change this, doesn't affect system upgrades
  #      Keep as the first version when the system was installed 
  system.stateVersion = "23.11"; # Did you read the comment?
}
