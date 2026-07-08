{ ... }:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    shellIntegration = {
      enableBashIntegration = true;
    };

    settings = {
      # Janela
      background_opacity = 0.85;
      dynamic_background_opacity = true;
      window_padding_width = 8;
      hide_window_decorations = true;
      confirm_os_window_close = 0;

      # Comportamento
      enable_audio_bell = false;
      scrollback_lines = 10000;
      remember_window_size = true;

      # Cursor
      cursor_shape = "beam";
      cursor_blink_interval = 0.5;

      # Abas
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";
    };
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
  };
}