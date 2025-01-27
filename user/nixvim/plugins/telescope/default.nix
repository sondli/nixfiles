{

  programs.nixvim.plugins.telescope = {
    enable = true;
    keymaps = {
      "<C-f>" = {
        action = "git_files";
      };
      "<leader>pf" = "find_files";
      "<leader>ps" = "live_grep";
    };
    settings = {
      defaults = {
        mappings = {
          i = {
            "<C-j>" = {
              __raw = "require('telescope.actions').move_selection_next";
            };
            "<C-k>" = {
              __raw = "require('telescope.actions').move_selection_previous";
            };
          };
        };
      };
    };
  };
}
