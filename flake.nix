{
  description = "ZaneyOS";

  inputs = {
    jerry.url = "github:justchokingaround/jerry";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    zig.url = "github:mitchellh/zig-overlay";
    ghostty.url = "git+ssh://git@github.com/ghostty-org/ghostty";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pollymc = {
      url = "github:fn2006/PollyMC";
    };
    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
    # This is required for plugin support.
    # hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
  };

  outputs =
    { nixpkgs, home-manager, nixpkgs-stable, zig, ghostty, spicetify-nix, pollymc, ... }@inputs:
    let
      system = "x86_64-linux";
      host = "dragneel";
      username = "cylis";
    in
    {
      nixosConfigurations = {
        "${host}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit host;
          };
          modules = [
            ./hosts/${host}/config.nix
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            ({pkgs, ...}: {
              nixpkgs.overlays = [pollymc.overlays.default];
              environment.systemPackages = [
                ghostty.packages.x86_64-linux.default
                pkgs.pollymc
              ];
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit host;
                inherit spicetify-nix;
                pkgs-stable = import nixpkgs-stable {
                  inherit system;
                  inherit inputs;
                  inherit username;
                  inherit host;
                  config.allowUnfree = true;
                };
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./hosts/${host}/home.nix;
            })
          ];
        };
      };
    };
}
