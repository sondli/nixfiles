{
  programs.nixvim = {
    plugins.obsidian = {
      enable = true;
      settings = {
        workspaces = [
          {
            name = "personal";
            path = "~/vaults/personal";
          }
          {
            name = "work";
            path = "~/vaults/work";
          }
        ];
      };
    };
    keymaps = [
      {
        action = ''<Cmd>ObsidianNew<CR>'';
        key = "<leader>on";
      }
    ];
  };
}
