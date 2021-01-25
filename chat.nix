{ config, pkgs, ... }:
let
  weechat-vidbina = with pkgs; weechat.override {
    # https://nixos.org/manual/nixpkgs/stable/#sec-weechat
    configure = { availablePlugins, ... }: {
      plugins = with availablePlugins; [
        (perl.withPackages (p: [ p.PodParser ]))
        python
      ];
      scripts = with weechatScripts; [
        wee-slack
        weechat-autosort
      ];
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    signal-cli
    signal-desktop
    tdesktop
    weechat-vidbina
    zoom-us
  ];
}
