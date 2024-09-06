#sway.nix

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
	sway      #sway wm
	swayidle  #idle locker
	swaylock  #screen locker
	swaybg    #background 
	waybar
	libnotify #for notifications
	mako      #notification daemon
	kitty     #terminal
	wofi      #launcher  
	grim      #screenshot utility
	slurp      
	pavucontrol
	playerctl
	pulseaudioFull 
	brightnessctl
	networkmanagerapplet
	papers
	gnome.nautilus
	gnome.eog
    ];
  };
}
