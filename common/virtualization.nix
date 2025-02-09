{config, pkgs, ... }:

{
  programs.dconf.enable = true;
  
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
	# gnome-boxes
	virtiofsd
    spice 
    spice-gtk
    spice-protocol
  ];
  
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;
}

