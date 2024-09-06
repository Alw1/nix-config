{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./sway-configuration.nix
    ];


  # Garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader = {
        efi = {
            canTouchEfiVariables = true;
            efiSysMountPoint = "/boot/"; 
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

  # enables support for Bluetooth
  hardware.bluetooth.enable = true; 
  hardware.bluetooth.powerOnBoot = false; 
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway --remember --asterisks";
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
  };

 #Services for laptop battery optimization
 services.power-profiles-daemon.enable = false;
 services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 80;

       #Optional helps save long term battery health
	   #START_CHARGE_THRESH_BAT0 = 40; 
	   #STOP_CHARGE_THRESH_BAT0 = 80; 
      };
};

 services.thermald.enable = true;

  programs = {
    zsh = {
	    enable = true;
	    enableCompletion = true;
	    autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
	    shellAliases = {
	      nixos-upgrade = ''nix flake upgrade --flake ~/nix-config && sudo nixos-rebuild switch --flake ~/nix-config'';
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
	mars-mips
	xspim
	qtspim
    cabal-install
    jdk
    git
    vscode
    libreoffice

    #Personal stuff
    spotify
    discord
    melonDS
	vencord

    #System stuff 
    gtk-engine-murrine
    gruvbox-gtk-theme
    xz
    pkg-config 
    gmp
    ncurses
    zlib
    ripgrep

    #CLI utilities
    hyfetch
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
