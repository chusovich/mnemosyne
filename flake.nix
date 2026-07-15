{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-core = {
      url = "github:chusovich/nix-core/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, nix-core, treefmt-nix, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.mnemosyne = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./configuration.nix
          nix-core.serverModules.default
        ];
      };

      formatter.${system} = treefmt-nix.lib.mkWrapper nixpkgs.legacyPackages.${system} {
        projectRootFile = "flake.nix";
        programs = {
          nixpkgs-fmt.enable = true;
          prettier.enable = true;
          yamlfmt.enable = true;
        };
        settings = {
          global.excludes = [
            "flake.lock"
            "*.env"
            "containers/**"
          ];
        };
      };
    };
}
