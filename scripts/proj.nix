{ pkgs }:

pkgs.writeShellScriptBin "proj" # bash
  ''
    if [ "$1" = "init" ]; then
      nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$2"
    fi
    if [ "$1" = "new" ]; then
      if ls | grep "$3" ; then
        mkdir -p "$3"
      fi
      nix flake new --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$2" "$3"
    fi
  ''
