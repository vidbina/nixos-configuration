{ config, pkgs, ... }:

{
  # TODO: cleanup later
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    (screenkey.overrideAttrs(oldAttrs: rec {
      # https://github.com/rasendubi/nixpkgs/pull/1/files
      preFixup = ''
        gappsWrapperArgs+=(--unset XMODIFIERS)
      '';
    }))
  ] ++ (with pythonPackages; [
    glances # alternative to htop for in-tree res utilisation and web view
  ]);
}
