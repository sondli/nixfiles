{
  programs.nixvim = {
    plugins.undotree.enable = true;
    keymaps = [
      {
        action = "<Cmd>UndotreeToggle<CR>";
        key = "<leader>u";
      }
    ];
  };
}
