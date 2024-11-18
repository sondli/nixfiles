{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
      };
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
    };
    extraConfigLua = ''
      		${builtins.readFile ./cmp.lua} 
      		'';
  };
}
