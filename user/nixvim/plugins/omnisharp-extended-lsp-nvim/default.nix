{ pkgs, ... }:
{
  programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
    omnisharp-extended-lsp-nvim
  ];

  home.file.".omnisharp/omnisharp.json" = {
    source = pkgs.writeText "omnisharp.json" ''
              {
      					"RoslynExtensionsOptions": {
                    "enableDecompilationSupport": true
                  }
      				}
    '';
  };

  programs.nixvim.extraConfigLua = ''
          		${builtins.readFile ./omnisharp-extended-lsp-nvim.lua} 
    	'';
}
