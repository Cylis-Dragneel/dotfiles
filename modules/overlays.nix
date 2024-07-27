{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      awesomeGit = prev.awesome.overrideAttrs (old: rec {
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
    }
    )
  ];
}
