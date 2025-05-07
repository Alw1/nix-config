{ ... }:

{
	programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableLsColors = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        rotom-update = ''nix flake update --flake ~/nix-config'';
        rotom-upgrade = ''sudo nixos-rebuild switch --flake ~/nix-config#$HOST'';
      };
    };

}
