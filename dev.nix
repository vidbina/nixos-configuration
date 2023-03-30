{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    devenv
  ]
    ++ (
    with haskellPackages; [
      apply-refact # for hlint --refactor
      hlint
      hscolour
      stylish-haskell
    ]
  )
    ++ (
    with pythonPackages; [
    ]
  );
}
