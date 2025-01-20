{
  programs.nixvim = {
    extraConfigLua = ''
      		${builtins.readFile ./easy-dotnet.lua} 
      		'';
  };
}
