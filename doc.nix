{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    (texLiveAggregatorFun { paths = [texLive lmodern]; })
    (texlive.combine { inherit (texlive) scheme-basic collection-basic; })
  ];
}

