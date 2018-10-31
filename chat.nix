{ config, pkgs ? (import ./nixpkgs.nix).default, ... }:

{
  environment.systemPackages = with pkgs; [
    irssi
    skypeforlinux
    telegram-cli
    (tdesktop.overrideAttrs(oldAttrs: rec {
      nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [
        wrapGAppsHook
      ];
    }))
    weechat
  ];
}
