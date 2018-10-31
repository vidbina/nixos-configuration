rec {
  new =  builtins.fetchTarball { # 18.09
    url = "https://github.com/NixOS/nixpkgs/archive/06fb0253afabb8cc7dc85db742e2de94a4d68ca0.tar.gz";
    sha256 = "0jkldgvdm8pl9cfw5faw90n0qbbzrdssgwgbihk1by4xq66khf1b";
  };
  old = builtins.fetchTarball { # vidbina's current (18.03)
    url = "https://github.com/NixOS/nixpkgs/archive/ba2a04f656d170306d587657359927acc9c51808.tar.gz";
    sha256 = "1nw2m7gz5s0qrj0vxl71w6ynl39rcqsdg8r3pcbmxdlkd1i9gjss";
  };
  default = old;
}
