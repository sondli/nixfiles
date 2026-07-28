{ config, pkgs, ... }:

{
  imports = [
    ./home-common.nix
    ./user/foot
    ./user/sway
  ];

  home.username = "sondli";
  home.homeDirectory = "/home/sondli";

	#gtk.gtk4.theme = null;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
