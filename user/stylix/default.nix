{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./../../wallpapers/nix.png;
    base16Scheme =
      "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };
    targets = {
      nixvim.enable = false;
    };
  };
}
