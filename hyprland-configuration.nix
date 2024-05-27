# hyrpland-configuration.nix

{ pkgs, config, ... }: {

  config = {

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
      };
    };
    
    environment.systemPackages = with pkgs; [
        hyprland
        sww

    ];
  };
}
