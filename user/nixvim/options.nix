{
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };

    opts = {
      termguicolors = true;
      scrolloff = 8;
      swapfile = false;
      hlsearch = false;
      incsearch = true;

      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      smartindent = true;

      cursorline = true;
      number = true;
      relativenumber = true;
      numberwidth = 2;
      ruler = false;
      guicursor = "";

      splitbelow = true;
      splitright = true;
      undofile = true;
      undolevels = 10000;

      signcolumn = "yes";
      colorcolumn = "120";

      winwidth = 10;
      winminwidth = 10;
      equalalways = false;

      conceallevel = 0;
    };
  };
}
