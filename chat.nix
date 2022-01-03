{ config, pkgs, ... }:
let
  weechat-vidbina = with pkgs; weechat.override {
    # https://nixos.org/manual/nixpkgs/stable/#sec-weechat
    configure = { availablePlugins, ... }: {
      scripts = with weechatScripts; [
        wee-slack
        weechat-autosort
        weechat-matrix-bridge
      ];
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    signal-desktop
    tdesktop
    weechat-vidbina
    zoom-us
  ];
}
