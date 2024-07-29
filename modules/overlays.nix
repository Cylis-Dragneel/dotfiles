{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      awesomeGit = prev.awesome.overrideAttrs (old: {
        pname = "awesomeGit";
        src = prev.fetchFromGitHub {
          owner = "awesomeWM";
          repo = "awesome";
          rev = "master";
          hash = "sha256-uaskBbnX8NgxrprI4UbPfb5cRqdRsJZv0YXXshfsxFU=";
        };
        patches = [];

          
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
    }
    )
  ];
}
