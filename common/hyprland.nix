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

			waybar = {
				enable = true;
			};
		};

		services.hypridle.enable = true;
		security.polkit.enable = true; 
     	xdg.portal.extraPortals = [ 
			pkgs.xdg-desktop-portal-gtk 
			pkgs.xdg-desktop-portal-wlr 
			pkgs.xdg-desktop-portal-hyprland
		];

		environment.sessionVariables = {
			NIXOS_OZONE_WL = "1";
			WLR_NO_HARDWARE_CURSORS = "1";
		};

		environment.systemPackages = with pkgs; [
			swww
			ags
			wl-clipboard
			libnotify 
			blueberry
			nautilus
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
