{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    haskellPackages.pandoc
    haskellPackages.pandoc-citeproc
    (texLiveAggregationFun { paths = [texLive lmodern]; })
    (texlive.combine { inherit (texlive) scheme-basic collection-basic; })
  ];
}

