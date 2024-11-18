{
  programs.nixvim = {
    plugins.fugitive.enable = true;
    keymaps = [
      {
        action = "<Cmd>Git<CR>";
        key = "<leader>gs";
      }
    ];
  };
}
