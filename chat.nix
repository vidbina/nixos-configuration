{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    tdesktop
    (
      weechat.override {
        # https://nixos.org/manual/nixpkgs/stable/#sec-weechat
        configure = { availablePlugins, ... }: {
          plugins = with availablePlugins; [
            python
          ];
          scripts = with weechatScripts; [
            wee-slack
            weechat-autosort
          ];
        };
      }
    )
    zoom-us
  ];
}
