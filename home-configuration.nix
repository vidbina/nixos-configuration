{ lib, config, options, modulesPath, specialArgs, pkgs }: {
  config.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = (lib.genAttrs [ "vidbina" ] (username: {
      # man home-configuration.nix
      programs = {
        home-manager.enable = true;

        urxvt =
          let
            my-rxvt-unicode = pkgs.rxvt-unicode.override {
              configure = { availablePlugins, ... }: {
                plugins = (builtins.attrValues availablePlugins) ++ [
                ];
              };
            };
          in
          {
            enable = true;
            package = my-rxvt-unicode;
            iso14755 = false;
            extraConfig = {
              "perl-lib" = "${my-rxvt-unicode}/lib/urxvt/perl";
              "perl-ext-common" = builtins.concatStringsSep "," [
                "default"
                "font-size"
                "url-select"
              ];
              "url-select.autocopy" = true;
              # TODO: Define launcher using ${xsel-copy-url}/bin/xsel-copy-url
              "url-select.launcher" = "xsel-copy-url";
              "url-select.underline" = true;
              # See `man urxvt` for guidance on the colors
              "background" = "#000000";
              "foreground" = "#ffffff";
              "color0" = "#000000"; # black, Black
              "color1" = "#ff0000"; # red, Red3
              "color2" = "#55ff55"; # green, Green3
              "color3" = "#ffd42a"; # yellow, Yellow3
              "color4" = "#2a7fff"; # blue, Blue3
              "color5" = "#dd55ff"; # magenta, Magenta3
              "color6" = "#00aad4"; # cyan, Cyan3
              "color7" = "#cccccc"; # white, AntiqueWhite
              "color8" = "#333333"; # bright black, Grey25
              "color9" = "#ff0066"; # bright red, Red
              "color10" = "#00ff00"; # bright green, Green
              "color11" = "#ff6600"; # bright yellow, Yellow
              "color12" = "#00b3ff"; # bright blue, Blue
              "color13" = "#ff2ad4"; # bright magenta, Magenta
              "color14" = "#00ffcc"; # bright cyan, Cyan
              "color15" = "#ffffff"; # bright white, White
            };
            fonts = [
              "xft:DejaVu Sans Mono:pixelsize=28:antialias=true"
              "xft:Fira Code:size=28:antialias=true"
              "xft:Iosevka:size=28:antialias=true"
            ];
            keybindings = {
              "C-minus" = "perl:font-size:decrease";
              "C-plus" = "perl:font-size:increase";
              "C-=" = "perl:font-size:reset";
              "M-u" = "perl:url-select:select_next";
            };
          };
      };

      manual = {
        # Use `home-manager-help`
        html.enable = true;

        # Use `man home-configuration.nix`
        manpages.enable = true;
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "text/html" = [ "xsel-copy-url.desktop" ];
          "x-scheme-handler/http" = [ "xsel-copy-url.desktop" ];
          "x-scheme-handler/https" = [ "xsel-copy-url.desktop" ];
          "x-scheme-handler/ftp" = [ "xsel-copy-url.desktop" ];
        };
      };
    }));
  };
}
