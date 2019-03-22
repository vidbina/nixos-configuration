self: super:

{
  #shotcut = super.shotcut.override {
  #  libsForQt5 = super.libsForQt59;
  #};
  #shotcut = super.shotcut.overrideAttrs(oldAttrs: rec {
  #  version = "19.02.28-overlay";
  #  src = super.fetchFromGitHub {
  #    owner = "mltframework";
  #    repo = "shotcut";
  #    rev = "v${version}";
  #    sha256 = "14l0cm81jy7syi08d8dg4nzp7s9zji9cycnf2mvh7zc7x069d1jr";
  #  };
  #});
}
