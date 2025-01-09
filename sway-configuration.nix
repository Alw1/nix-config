{ pkgs, config, ... }: {
    config = {
		programs = {
			sway = {
				enable = true;
				wrapperFeatures.gtk = true;
			};
			xwayland.enable = true;
		};

		services.gnome.gnome-keyring.enable = true;

		environment.systemPackages = with pkgs; [
			sway      
			swayidle  
			swaylock  
			swaybg    
			waybar
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
			kanagawa-gtk-theme
			gruvbox-gtk-theme
		];
  };
}
