{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      hide_window_decorations = "titlebar-only";
      macos_option_as_alt = "yes";
      confirm_os_window_close = 0;
    };
  };

  stylix.fonts.sizes.terminal = 14;
}
