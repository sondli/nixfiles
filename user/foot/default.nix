{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ foot ];

  programs.foot = {
    enable = true;
  };
}
