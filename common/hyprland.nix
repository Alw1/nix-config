{ config, pkgs, ... }: {
	config = {
		programs = {
			hyprland = {
				enable = true;
				xwayland.enable = true;
				withUWSM  = true;

			};
			hyprlock.enable = true;
			hypridle.enable = true;
			nm-applet.enable = true;
			dconf.enable = true;
			nautilus-open-any-terminal = {
				enable = true;
				terminal = "kitty";
			};
		};

		environment.sessionVariables = {
			NIXOS_OZONE_WL = "1";
		};

		services.gnome.gnome-keyring.enable = true;

		environment.systemPackages = with pkgs; [
			waybar
			wl-clipboard
			libnotify 
			mako
			kitty
			grim
			slurp
			pavucontrol
			playerctl
			pulseaudioFull 
			brightnessctl
			networkmanagerapplet
			papers
			nautilus
			eog
			fuzzel
		];
	};
}
