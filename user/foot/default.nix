{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ foot ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
      };
    };

  };
}
