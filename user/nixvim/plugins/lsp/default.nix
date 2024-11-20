{
  programs.nixvim = {
    plugins.web-devicons.enable = true;
    plugins.lsp = {
      enable = true;
      servers = {
        nixd = {
          enable = true;
          extraOptions = {
            settings = {
              nixd = {
                formatting = {
                  command = "nixfmt";
                };
              };
            };
          };
        };
        lua_ls = {
          enable = true;
          settings.diagnostics.globals = [ "vim" ];
        };
        rust_analyzer = {
          enable = true;
          installCargo = false;
          installRustc = false;
        };
        omnisharp.enable = true;
        #csharp_ls.enable = true;
        html.enable = true;
        gopls.enable = true;
        cssls.enable = true;
        clangd.enable = true;
        jsonls.enable = true;
        ts_ls.enable = true;
        svelte.enable = true;
        tailwindcss = {
          enable = true;
          extraOptions = {
            init_options = {
              userLanguages = {
                elixir = "html-eex";
                eelixir = "html-eex";
                heex = "html-eex";
              };
            };
          };
        };
        sqls.enable = true;
        elixirls.enable = true;
      };
      keymaps = {
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          "<leader>ca" = "code_action";
          "<leader>rn" = "rename";
          "<leader>f" = "format";
        };
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
      };
    };
  };
}
