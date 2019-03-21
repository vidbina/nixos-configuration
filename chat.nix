{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    telegram-cli
    (tdesktop.overrideAttrs(oldAttrs: rec {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
        wrapGAppsHook
      ];
    }))
    weechat
  ];
}
