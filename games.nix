{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anki
    godot
    stockfish
    #(
    #  with python3Packages; buildPythonPackage rec {
    #    pname = "chs";
    #    version = "2.2.0";
    #    #format = "wheel";

    #    #src = fetchFromGitHub {
    #    #  owner = "nickzuber";
    #    #  repo = "chs";
    #    #  rev = "refs/tags/v${version}";
    #    #  sha256 = "09kgff7q6hbc5qjdb0c6lq5mzddd7m2dkkzkfj0xmqwj6qjy71hm";
    #    #};

    #    postUnpack = ''
    #      ls -la chs-2.2.0
    #      cat chs-2.2.0/README.md
    #    '';

    #    src = fetchPypi {
    #      inherit pname version;
    #      sha256 = "0523irjc0yfx3qjg93hikrsc02lv4vnxswj78vpxrcjmf3j0dhw1";
    #    };

    #    #preConfigure = ''
    #    #  ls -la .
    #    #'';

    #    #propagatedBuildInputs = [ setuptools ];

    #    meta = with stdenv.lib; {
    #      homepage = https://github.com/nickzuber/chs;
    #      description = "A command-line interface to play chess against the Stockfish engine";
    #      license = licenses.mit;
    #    };
    #  }
    #)
    #steam
    #steam-run
  ];

  hardware.opengl = {
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  hardware.pulseaudio.support32Bit = true;
}
