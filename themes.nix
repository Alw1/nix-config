
{ pkgs, config, ... }: {

	gtk.enable = true;

	environment.systemPackages = with pkgs; [
		#Add themes here
    ];
 



}
