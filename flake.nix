{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nix-core = {
      url = "github:chusovich/nix-core/0.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-core, ... }: {
    nixosConfigurations.mnemosyne = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        ./configuration.nix
        nix-core.serverModules.default
      ];
    };
  };
}
