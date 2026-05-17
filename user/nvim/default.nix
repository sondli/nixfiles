{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    initLua = lib.fileContents ./init.lua;
  };

  home.packages = with pkgs; [
    gcc
    tree-sitter
    lua-language-server
    roslyn-ls
    nil
    nixfmt
    typescript-language-server
    vue-language-server
		netcoredbg
  ];

  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
