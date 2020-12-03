{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # deno # WIP
    #htmlTidy
    #mitscheme
    #stdenv
    (import ./emacs.nix { inherit pkgs; })
    asciinema
    (
      buildGoPackage rec {
        pname = "checkmake";
        version = "2020-11-30";

        goPackagePath = "github.com/mrtazz/checkmake";

        nativeBuildInputs = [ makeWrapper ];

        src = fetchFromGitHub {
          owner = "mrtazz";
          repo = pname;
          rev = "575315c9924da41534a9d0ce91c3f0d19bb53ffc";
          sha256 = "121rsl9mh3wwadgf8ggi2xnb050pak6ma68b2sw5j8clmxbrqli3";
        };

        wrapperPath = stdenv.lib.makeBinPath (
          [
            pandoc
          ]
        );

        postFixup = ''
          wrapProgram $bin/bin/checkmake \
            --prefix PATH : "${wrapperPath}"
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
      }
    )
    cmakeCurses
    darcs
    gdb
    ghc
    ghcid
    git
    git-lfs
    github-cli
    glibc
    gnumake
    go
    go-jira
    html-tidy
    httpie
    httplab # interactive web server
    jq # pretty-print JSON
    k9s
    neovim
    shfmt
    sqlite
    subversion
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

  nixpkgs.config = {};
}
