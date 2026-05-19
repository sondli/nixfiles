{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [ foot ];

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = lib.mkForce "JetBrainsMono Nerd Font:size=13.5";
      };
    };
  };
}
