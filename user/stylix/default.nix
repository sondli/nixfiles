{ config, pkgs, ... }:

{
  stylix = {
    enable = true;
    image = ./../../wallpapers/cat.png;
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
