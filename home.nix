{ config, pkgs, ... }:

{
  imports = [
    ./user/zsh
    ./user/nixvim
    ./user/foot
    ./user/sway
    ./user/tmux
    ./user/stylix
    ./user/firefox
    ./user/yazi
  ];

  home.username = "sondli";
  home.homeDirectory = "/home/sondli";

  programs.git = {
    enable = true;
    userName = "sondli";
    userEmail = "sondre.lillelien@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "vs-ssh.visualstudio.com" = {
        hostname = "vs-ssh.visualstudio.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa_edrmedeso";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  home.stateVersion = "23.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
  ];

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
