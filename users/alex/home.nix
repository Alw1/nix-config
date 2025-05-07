{ pkgs, ... }: {

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.kanagawa-gtk-theme;
      name = "Kanagawa";
    };

    iconTheme = {
      package = pkgs.kanagawa-icon-theme;
      name = "Kanagawa";
    };

    font = {
      name = "Intel One Mono";
      package = pkgs.intel-one-mono;
      size = 11;
    };
  };

  programs.home-manager-enable = true;
  home.stateVersion = "24.11";
}
