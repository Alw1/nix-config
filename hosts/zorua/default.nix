{ unstablePkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../common
    ../../users/alex/user.nix
  ];

  hyprland.enable = true;
  GNOME.enable = true;
  gaming.enable = true;

  hardware.opengl.enable = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings.auto-optimise-store = true;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.bluetooth = {
		enable = true;
		powerOnBoot = false;
  };

  programs.nix-ld.enable = true;
  services = {
    openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "prohibit-password";
      };
    };

    gvfs.enable = true;
    udisks2.enable = true;
    printing.enable = true;

    displayManager.ly = {
      enable = true;
      settings = {
        animation = "matrix";
        load = true;
        save = true;
        clear_password = true;
      };
    };

    xserver = {
      enable = true;
      xkb.layout = "us";
      xkb.variant = "";
    };
  };

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/";
    };
    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };
  };

  programs = {
	   neovim = {
	     enable = true;
	     defaultEditor = true;
		 package = unstablePkgs.neovim-unwrapped;
    };
  };

  networking.hostName = "zorua";

  system.stateVersion = "23.11";
}
