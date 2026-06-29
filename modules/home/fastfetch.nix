{ config, lib, ... }:

let
  logoPath = "${config.xdg.configHome}/fastfetch/logo.png";
in
{
  xdg.configFile."fastfetch/logo.png".source =
  config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/Pictures/fastfetch/logo.png";

  programs.fastfetch = {
    enable = true;

    settings = {
      logo = {
        type = "kitty";
        source = logoPath;

        width = 34;

        padding = {
          top = 1;
          left = 1;
          right = 4;
        };
      };

      display = {
        separator = "  ";
        disableLinewrap = true;
        hideCursor = true;

        color = {
          keys = "blue";
          separator = "magenta";
        };

        percent = {
          type = 9;

          color = {
            green = "cyan";
            yellow = "yellow";
            red = "red";
          };
        };
      };

      modules = [
        "break"

        {
          type = "custom";
          format = "{#blue}╭──────────── SISTEMA ────────────╮";
        }

        {
          type = "os";
          key = "{#cyan}├─   Sistema";
        }

        {
          type = "kernel";
          key = "{#cyan}├─   Kernel";
        }

        {
          type = "uptime";
          key = "{#cyan}├─ 󰔟  Uptime";
        }

        {
          type = "packages";
          key = "{#cyan}╰─ 󰏖  Pacotes";
        }

        {
          type = "custom";
          format = "{#magenta}╭─────────── HARDWARE ───────────╮";
        }

        {
          type = "cpu";
          key = "{#magenta}├─   CPU";
        }

        {
          type = "gpu";
          key = "{#magenta}├─ 󰢮  GPU";
        }

        {
          type = "memory";
          key = "{#magenta}├─   Memória";
          percent.type = 3;
        }

        {
          type = "disk";
          key = "{#magenta}╰─ 󰋊  Disco";
          folders = [ "/" ];
          percent.type = 3;
        }

        {
          type = "custom";
          format = "{#blue}╭─────────── AMBIENTE ───────────╮";
        }

        {
          type = "wm";
          key = "{#blue}├─   Compositor";
        }

        {
          type = "shell";
          key = "{#blue}├─   Shell";
        }

        {
          type = "terminal";
          key = "{#blue}├─   Terminal";
        }

        {
          type = "terminalfont";
          key = "{#blue}╰─ 󰛖  Fonte";
        }

        {
          type = "custom";
          format = "{#magenta}╰────────────────────────────────╯";
        }

        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];
    };
  };
}