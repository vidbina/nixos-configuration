with import <nixpkgs> { };
#with stdenv fetchurl qt5;

#{ stdenv, cups, fetchurl, qt5 }:

stdenv.mkDerivation rec {
  name = "qelectrotech-${version}";
  version = "0.6";
  tag = "20180306";

  src =
    let
      base = "https://download.tuxfamily.org/qet/tags";
    in
    fetchurl {
      url = "${base}/${tag}/qelectrotech-${version}-src.tar.gz";
      sha256 = "1b5van2n6lc9l6xmb1vzkgbx7prxvpw0kjj9dkpwmzj6gxichi4i";
    };

  buildInputs = [
    qt5.qmake
    qt5.qtsvg
  ];

  preInstall = ''
    mkdir -p $out/pre
    cp -R . $out/pre
  '';

  postInstall = ''
    mkdir -p $out/bin
    cp qelectrotech $out/bin/qelectrotech

    cp -R lang $out/share/lang
    cp -R docs $out/share/doc
    cp -R . $out/share/origin
  '';

  patches = [
    ./prefix.patch
  ];

  meta = with stdenv.lib; {
    description = "free software to create electric diagrams";
    homepage = "https://qelectrotech.org";
    license = licenses.gpl2;
    maintainers = with maintainers; [ vidbina ];
    platforms = with platforms; unix;
  };
}
