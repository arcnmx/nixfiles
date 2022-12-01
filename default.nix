{ nixpkgs, darwin, ... }@inputs: let
  tree = (inputs.tree.tree {
    inherit inputs;
    folder = ./.;
    config = {
      "/" = {
        excludes = [
          "flake"
          "default"
        ];
      };
    };
  }).impure;
  lib = inputs.nixpkgs.lib;
  inherit (lib.attrsets) mapAttrs;
in {
  inherit tree;
  nixosConfigurations = mapAttrs (name: path: nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      path
    ];
    } ) tree.nixos.systems;
  darwinConfigurations = mapAttrs (name: path: darwin.lib.darwinSystem {
    system = "x86_64-linux";
    modules = [
      path
    ];
    } ) tree.darwin.systems;
}
