{ config, pkgs, ... }:

{
  # TODO: cleanup later
  # nixpkgs.config.allowBroken = true;

  environment.systemPackages = with pkgs; [
  ] ++ (with pythonPackages; [
    glances # alternative to htop for in-tree res utilisation and web view
    (screenkey.override rec {
      version = "0.9";
      name = "screenkey-${version}";

      disabled = !isPy27; # error: invalid command 'bdist_wheel'

      XMODIFIERS="";

      preConfigure = ''
        substituteInPlace setup.py --replace "/usr/share" "./share"

        substituteInPlace Screenkey/xlib.py --replace "libX11.so.6" "${xorg.libX11}/lib/libX11.so.6"

        substituteInPlace Screenkey/xlib.py --replace "libXtst.so.6" "${xorg.libXtst}/lib/libXtst.so.6"
      '';

      propagatedBuildInputs = [ distutils_extra intltool xorg.xmodmap pygtk setuptools xlib ] ++ (with xorg; [ libX11 libXtst ]);

      preFixup = ''
        wrapProgram $out/bin/screenkey --unset XMODIFIERS
      '';

      src = pkgs.fetchgit {
        url = https://github.com/wavexx/screenkey.git;
        rev = "c6d240a676d7a4df284e0010d0698e1f9c5fd44e";
        sha256 = "14g7fiv9n7m03djwz1pp5034pffi87ssvss9bc1q8vq0ksn23vrw";
      };
    })
  ]);
}
