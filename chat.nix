{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (tdesktop.overrideAttrs(oldAttrs: rec {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
        wrapGAppsHook
      ];
    }))
    weechat
  ];
}
