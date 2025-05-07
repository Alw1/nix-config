{ ... }:

{

  networking = {
    networkmanager.enable = true;
    firewall.enable = true;
    nftables.enable = true;

    # openconnect = {
    #   enable = true;
    #   user = "wyatta4";
    #   server = "ramsvpn.vcu.edu";
    # };

  };

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "prohibit-password";
    };
  };
}



