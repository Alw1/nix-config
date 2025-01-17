{ config, pkgs, ... }: {
    config = {
		programs = {
			sway = {
				enable = true;
				wrapperFeatures.gtk = true;
			};
			xwayland.enable = true;
		    nm-applet.enable = true;
		};

		services.dconf.enable = true;
		services.gnome.gnome-keyring.enable = true;

		environment.systemPackages = with pkgs; [
			sway
			swayidle
			swaylock
			swaybg
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
