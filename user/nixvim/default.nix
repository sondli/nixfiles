{ config, pkgs, ... }:

{
  imports = [
    ./options.nix
    ./remap.nix

    ./plugins/obsidian
    ./plugins/telescope
    ./plugins/dap
    ./plugins/noice
    ./plugins/lsp
    ./plugins/cmp
    ./plugins/fugitive
    ./plugins/undotree
    ./plugins/nvim-tree
		./plugins/package-info
		./plugins/harpoon
		./plugins/markdown-preview
		./plugins/omnisharp-extended-lsp-nvim
		./plugins/dadbod
  ];

  home.packages = with pkgs; [ nixfmt-rfc-style ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    colorschemes.gruvbox.enable = true;

    extraPlugins = with pkgs.vimPlugins; [ 
			plenary-nvim 
			vim-csharp
		];

    plugins = {
      lualine.enable = true;
      luasnip.enable = true;
			ts-autotag.enable = true;
      treesitter.enable = true;
      treesitter.settings.highlight.enable = true;
    };
  };
}