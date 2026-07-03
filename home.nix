{ config, pkgs, ... }:

{
  imports = [
    ./user/zsh
    ./user/nvim
    ./user/foot
    ./user/sway
    ./user/tmux
    ./user/stylix
    ./user/claude_code
    ./user/devin
    ./user/yazi
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home.username = "sondli";
  home.homeDirectory = "/home/sondli";

	#gtk.gtk4.theme = null;

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sondli";
        email = "sondre.lillelien@gmail.com";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      core = {
        sshCommand = "ssh -i ~/.ssh/personal -o IdentitiesOnly=yes";
        autocrlf = "input";
      };
    };
    includes = [
      {
        condition = "gitdir:~/projects/construsoft/";
        contents = {
          user = {
            name = "sondli";
            email = "sondre.lillelien@construsoft.com";
          };
          core = {
            sshCommand = "ssh -i ~/.ssh/construsoft -o IdentitiesOnly=yes";
          };
        };
      }
    ];
  };

  programs.ssh = {
    enable = true;
		enableDefaultConfig = false;
  };

  home.stateVersion = "25.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
