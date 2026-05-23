{ config, pkgs, ... }:
{
  programs.claude-code = {
    enable = true;
    skills = ./skills;
  };
}
