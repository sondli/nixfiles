{
  programs.nixvim = {
    plugins.noice = {
      enable = true;
      settings = {
        notify.enabled = false;
        messages.enabled = false;
      };
    };
  };
}
