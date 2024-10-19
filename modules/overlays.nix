{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (final: prev: {
      awesomeGit = prev.awesome.overrideAttrs (old: {
        pname = "awesomeGit";
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "master";
          hash = "sha256-CpieBypRPQ9h/RzWskvv/zSVbPPBHCWOIdrGBySBtlQ=";
        };
        patches = [ ];

        postPatch = ''
          patchShebangs tests/examples/_postprocess.lua
        '';
      });
      hilbish-git = prev.hilbish.overrideAttrs (old: {
        pname = "hilbish-git";
        src = prev.fetchFromGitHub {
          owner = "Rosettea";
          repo = "Hilbish";
          rev = "ea233facc87c61e55bca60f5dc6885f6307cc179";
          hash = "sha256-z3lEkbAU3thWNszFsv23uJdASHil9Wgb8SA925PIq7A=";
        };
      });
    })
    (import (
      builtins.fetchGit {
        url = "https://github.com/nix-community/emacs-overlay.git";
        ref = "master";
        rev = "e171f7ac85c6aba2463fee6f22288d6d249c9c7a";
      }
    ))
  ];
}
