{
  programs.nixvim = {
    plugins.dap = {
      enable = true;
      adapters.executables = {
        gdb = {
          command = "gdb";
          args = [ "-i" "dap" ];
        };
      };
      extensions = {
        dap-ui = {
          enable = true;
        };
        dap-virtual-text.enable = true;
      };
    };
    keymaps = [
      {
        action = ''<Cmd>lua require("dapui").toggle()<CR>'';
        key = "<leader>dt";
      }
      {
        action = ''<Cmd>lua require("dap").toggle_breakpoint()<CR>'';
        key = "<leader>db";
      }
      {
        action = ''<Cmd>lua require("dap").continue()<CR>'';
        key = "<leader>dc";
      }
      {
        action = ''<Cmd>lua require("dap").step_over()<CR>'';
        key = "<leader>do";
      }
      {
        action = ''<Cmd>lua require("dap").step_into()<CR>'';
        key = "<leader>di";
      }
    ];
    extraConfigLua = ''
      		${builtins.readFile ./dap.lua} 
      		'';
  };
}
