{pkgs, config, ...}:
let 
	user = "alex";
in {
	users.users.${user} = {
		isNormalUser = true;
		description = "Alex Wyatt";
		shell = pkgs.zsh;
		extraGroups = [ "docker" "networkmanager" "wheel" "libvirtd" "plugdev" ];
	};
}
