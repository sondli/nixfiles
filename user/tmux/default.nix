{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ tmux ];

  programs.tmux = {
    enable = true;
    shell = "${pkgs.zsh}" + "/bin/zsh";
    baseIndex = 1;
    prefix = "C-a";
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      gruvbox
    ];
    extraConfig = ''
      ${builtins.readFile ./binds.conf} 
    '';

  };

}
