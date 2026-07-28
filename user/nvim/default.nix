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
    defaultEditor = true;
    initLua = lib.fileContents ./init.lua;
  };

  home.packages =
    with pkgs;
    lib.optionals stdenv.isLinux [
      gcc
    ]
    ++ [
      tree-sitter
      lua-language-server
      # roslyn-ls
      nil
      nixfmt
      typescript-language-server
      vue-language-server
      prettierd
      netcoredbg
      vscode-langservers-extracted
    ];

  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
