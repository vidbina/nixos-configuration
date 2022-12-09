{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ ]
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
