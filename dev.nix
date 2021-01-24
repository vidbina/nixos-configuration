{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # deno # WIP
    #htmlTidy
    #mitscheme
    #stdenv
    (import ./emacs.nix { inherit pkgs; })
    asciinema
    cmakeCurses
    darcs
    gdb
    ghc
    ghcid
    ghidra-bin
    git
    git-lfs
    github-cli
    glibc
    gnumake
    go
    go-jira
    hexyl
    html-tidy
    httpie
    httplab # interactive web server
    jq # pretty-print JSON
    k9s
    neovim
    shfmt
    sqlite
    subversion
    vidbina.checkmake
    wuzz # cURL-like TUI HTTP request inspection tool
    xxd
    yq # pretty-print YAML
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
      yamllint
    ]
  )
  ;

  nixpkgs.config = {
    packageOverrides = pkgs: with pkgs; {
      vidbina = {
        checkmake = buildGoPackage rec {
          pname = "checkmake";
          version = "0.1.0-2020.11.30";

          goPackagePath = "github.com/mrtazz/checkmake";

          src = fetchFromGitHub {
            owner = "mrtazz";
            repo = pname;
            rev = "575315c9924da41534a9d0ce91c3f0d19bb53ffc";
            sha256 = "121rsl9mh3wwadgf8ggi2xnb050pak6ma68b2sw5j8clmxbrqli3";
          };

          nativeBuildInputs = [ pandoc ];

          preBuild =
            let
              buildVars = {
                version = version;
                buildTime = "N/A";
                builder = "nix";
                goversion = "$(go version | egrep -o 'go[0-9]+[.][^ ]*')";
              };
              buildVarsFlags = lib.concatStringsSep " " (lib.mapAttrsToList (k: v: "-X main.${k}=${v}") buildVars);
            in
            ''
              buildFlagsArray+=("-ldflags=${buildVarsFlags}")
            '';

          postInstall = ''
            pandoc -s -t man -o checkmake.1 go/src/${goPackagePath}/man/man1/checkmake.1.md
            mkdir -p $out/share/man/man1
            mv checkmake.1 $out/share/man/man1/checkmake.1
          '';

          meta = with stdenv.lib; {
            description = "Experimental tool for linting and checking Makefiles";
            homepage = https://github.com/mrtazz/checkmake;
            license = licenses.mit;
            maintainers = with maintainers; [ vidbina ];
            platforms = platforms.linux;
            longDescription = ''
              checkmake is an experimental tool for linting and checking
              Makefiles. It may not do what you want it to.
            '';
          };
        };
      };
    };
  };
}
