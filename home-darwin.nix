{ config, pkgs, ... }:

{
  imports = [
    ./home-common.nix
    ./user/kitty
  ];

  home.username = "sondli";
  home.homeDirectory = "/Users/sondli";

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  stylix.targets = {
    gtk.enable = false;
    gtksourceview.enable = false;
    gedit.enable = false;
    xresources.enable = false;
    sxiv.enable = false;
    blender.enable = false;
    vencord.enable = false;
    forge.enable = false;
  };
}
