{
  programs.nixvim = {
    extraConfigLua = ''
      			${builtins.readFile ./lua/remap.lua} 
      		'';
  };
}
