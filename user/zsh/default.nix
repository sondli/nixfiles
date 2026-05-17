{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ starship ];

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -lah";
      sd = "cd ~ && cd \$(find * -type d | fzf)";
      yz = "yazi";
      cfg = "cd ~/.config/nixos/";
      nodedev = "nix-shell ~/.config/nixos/shells/node.nix";
      dotnetdev = "nix-shell ~/.config/nixos/shells/dotnet.nix";
    };
    initContent = ''
      setopt MENU_COMPLETE
      bindkey '^I' menu-complete
      bindkey "$terminfo[kcbt]" reverse-menu-complete
      bindkey '^Y' autosuggest-accept
    '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
