{ config, pkgs, lib, ... }: {

  imports = [
    ./hardware-configuration.nix
    ../../common
	../../users/alex.nix
  ];

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  hardware.bluetooth.enable = true;

	services.mongodb = {
	  enable = true;
	  package = pkgs.mongodb-ce;
	};

  services = {
	openssh = {
		enable = true;
		settings = {
			X11Forwarding = true;
			PermitRootLogin = "no"; # disable root login
			PasswordAuthentication = false; # disable password login
		};
		openFirewall = true;
    };

	gvfs.enable = true;
	udisks2.enable = true;
	printing.enable = true;

	power-profiles-daemon.enable = false; # Need to disable to enable tlp
	thermald.enable = true;
	tlp = {
	  enable = true;
	  settings = {
		CPU_SCALING_GOVERNOR_ON_AC = "performance";
		CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

		CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
		CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

		CPU_MIN_PERF_ON_AC = 0;
		CPU_MAX_PERF_ON_AC = 100;
		CPU_MIN_PERF_ON_BAT = 0;
		CPU_MAX_PERF_ON_BAT = 80;
	  };
	};

	blueman.enable = true;

	displayManager.ly = {
		enable = true;
		settings = {
			animation = "matrix";
			load = true;
			save = true;
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
  		device = "nodev";
  	};
  };
 
	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;
			shellAliases = {
				update-flake = ''nix flake update --flake ~/nix-config'';
				update-nix = ''sudo nixos-rebuild switch --flake ~/nix-config'';
				update-toaster = ''sudo nixos-rebuild switch --flake ~/nix-config#toaster'';
			 };
		};

		firefox.enable = true;

		steam = {
			enable = true;
			remotePlay.openFirewall = true; 
			dedicatedServer.openFirewall = true; 
		};	

	};

  networking = {
    hostName = "toaster";
    networkmanager.enable = true;
  };

  system.stateVersion = "23.11"; 
}
