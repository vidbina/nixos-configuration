{ config, options, pkgs, lib, ... }:

let
  cfg = config.my-config;
in
{
  options = with pkgs.lib; {
    my-config = {
      handle = mkOption {
        type = types.str;
        default = "vidbina";
        description = "Handle under which to configure the user. This is the Nix keyname and may be different from the username, but for good measure should not.";
      };

      uid = mkOption {
        type = types.ints.positive;
        default = 1988;
      };

      name = mkOption {
        type = types.str;
        default = cfg.handle;
      };

      email = mkOption {
        type = types.str;
        default = "vid@bina.me";
      };

      description = mkOption {
        type = types.str;
        default = "David Asabina <vid@bina.me>";
      };

      cryptHomeLuks = mkOption {
        type = types.str;
        default = "/dev/store/store";
      };
    };
  };

  config = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
      defaultUserShell = "/run/current-system/sw/bin/zsh";

      users = (lib.genAttrs [ cfg.handle ] (username: with cfg; {
        inherit uid name description cryptHomeLuks; # from cfg

        isNormalUser = true;
        createHome = true;
        home = "/home/${username}";
        extraGroups = [
          "beep"
          "dialout"
          "lp"
          "network"
          "networkmanager"
          "wheel"
          "wireshark"
        ];
        initialPassword = "#unsecure";
      }));
    };

    environment = {
      variables = {
        # https://doc.qt.io/qt-5/highdpi.html
        QT_SCREEN_SCALE_FACTORS = "2";
      };
    };

    # TODO: Refactor into a smarter implementation
    # Something that is more multi-user compatible
    # The current config is single-user oriented
    nix.trustedUsers = [ cfg.handle ];
  };
}
