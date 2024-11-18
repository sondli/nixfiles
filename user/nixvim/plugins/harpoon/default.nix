{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    harpoon2
  ];

  programs.nixvim.extraConfigLua = ''
          		${builtins.readFile ./harpoon.lua} 
    	'';
}
