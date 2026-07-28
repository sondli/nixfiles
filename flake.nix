{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      stylix,
      ...
    }:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          inherit system;
          modules = [
            ./configuration.nix
          ];
        };
      };
      homeConfigurations = {
        sondli = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            stylix.homeModules.stylix
            ./home.nix
          ];
        };
        macbook = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          modules = [
            stylix.homeModules.stylix
            ./home-darwin.nix
          ];
        };
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
