{ config, pkgs, ... }:

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
			nixfiles = "cd ~/nixfiles/";
      rustdev = "nix-shell ~/nixfiles/shells/rust.nix";
      dotnetdev = "nix-shell ~/nixfiles/shells/dotnet.nix";
    };
    initExtra = ''
      			bindkey '^I' autosuggest-accept
						bindkey "$terminfo[kcbt]" menu-complete
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
