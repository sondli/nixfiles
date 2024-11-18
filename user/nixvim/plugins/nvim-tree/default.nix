{
  programs.nixvim = {
    plugins.nvim-tree.enable = true;
    extraConfigLua = ''
      		${builtins.readFile ./nvim-tree.lua} 
      		'';
  };
}
