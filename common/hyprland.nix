{ config, pkgs, ... }: {
	config = {
		programs = {
			hyprland = {
				enable = true;
				xwayland.enable = true;
			};
			hyprlock.enable = true;
			nm-applet.enable = true;
			dconf.enable = true;
		};

		services.hypridle.enable = true;

		environment.sessionVariables = {
			NIXOS_OZONE_WL = "1";
			WLR_NO_HARDWARE_CURSORS = "1";
		};

		environment.systemPackages = with pkgs; [
			swww
			waybar
			xdg-desktop-portal-hyprland
			wl-clipboard
			libnotify 
			blueberry
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
			eog
			fuzzel
			kanagawa-icon-theme
		];
	};
}
