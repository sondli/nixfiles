{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./../../wallpapers/a_blue_and_orange_background.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
    };
    targets = {
      neovim.enable = false;
    };
  };
}
