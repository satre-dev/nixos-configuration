{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";

    # Add Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-master, home-manager }: {
    nixosConfigurations = {
      satreNixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit home-manager; };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix

          # Integrate Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.satre = import ./users/satre-home.nix;
            };
          }

          {
            nixpkgs.overlays = [
              (final: prev: {
                wgnord = nixpkgs-master.legacyPackages.x86_64-linux.wgnord;
              })
            ];
          }
        ];
      };
    };
  };
}
