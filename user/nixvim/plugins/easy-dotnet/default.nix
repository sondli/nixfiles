{ pkgs, ... }:
{
  programs.nixvim = {
		plugins.fzf-lua.enable = true;
    extraPlugins = with pkgs.vimPlugins; [ easy-dotnet-nvim ];
    extraConfigLua = ''
      ${builtins.readFile ./easy-dotnet.lua} 
    '';
  };
}
