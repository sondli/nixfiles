{
  programs.nixvim = {
    plugins.package-info = {
			enable = true;
			luaConfig.post = ''
      		${builtins.readFile ./package-info.lua} 
      		'';
			};
  };
}
