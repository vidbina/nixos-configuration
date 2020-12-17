{ config, pkgs, ... }:

{
  # TODO: cleanup later
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
    keymon
    slop
    (
      screenkey.overrideAttrs (
        oldAttrs: rec {
          # https://github.com/rasendubi/nixpkgs/pull/1/files
          iconPkg = pkgs.tango-icon-theme;
          preFixup = ''
            $(mkdir -p $out/share/icons/hicolor; cd ${iconPkg}/share/icons/Tango; cp -R . $out/share/icons/hicolor)
            gappsWrapperArgs+=(--unset XMODIFIERS)
          '';
        }
      )
    )
  ];
}
