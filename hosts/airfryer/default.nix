{ config, pkgs, lib, ... }: {

	imports = [
		./hardware-configuration.nix
		../../common
		../../users/alex.nix
	];

	time.timeZone = "America/New_York";
	i18n.defaultLocale = "en_US.UTF-8";

	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = false;

	services = {
		openssh = {
			enable = true;
			settings = {
				X11Forwarding = false;
				PermitRootLogin = "no";
			};
			openFirewall = true;
		};

		gvfs.enable = true;
		udisks2.enable = true;
		printing.enable = true;

		power-profiles-daemon.enable = false; # Need to disable to enable tlp
		thermald.enable = true;
		upower.enable = true;
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
			#useOSProber = true; # Use when dual booting to find other OS
			device = "nodev";
		};
	};

	programs = {
		zsh = {
			enable = true;
			enableCompletion = true;
			enableLsColors = true;
			autosuggestions.enable = true;
			syntaxHighlighting.enable = true;
			shellAliases = {
				airfryer-update = ''nix flake update --flake ~/nix-config'';
				airfryer-upgrade = ''sudo nixos-rebuild switch --flake ~/nix-config#airfryer'';
			};
		};

		firefox.enable = true;

		steam = {
			enable = true;
			remotePlay.openFirewall = true; 
			dedicatedServer.openFirewall = true; 
			protontricks.enable = true;
		};	

		neovim = {
			enable = true;
			defaultEditor = true;
		};
	};

	hardware.rtl-sdr.enable = true;
	xdg.portal.wlr.enable = true;
	networking = {
		hostName = "airfryer";
		networkmanager.enable = true;
		# firewall.enable = true;
		# nftables.enable = true;
	};

	system.stateVersion = "23.11"; 
}
