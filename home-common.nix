{ config, pkgs, ... }:

{
  imports = [
    ./user/zsh
    ./user/nvim
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

  home.packages = with pkgs; [
    fzf
    ripgrep
    jq
    unzip
    btop
    devin-cli
  ];

  home.sessionVariables = { };

  programs.home-manager.enable = true;
}
