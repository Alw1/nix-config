{ config, pkgs, ... }: {
  networking.openconnect = {
    enable = true;
    user = "wyatta4";
    server = "ramsvpn.vcu.edu";
  };
}
