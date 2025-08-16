{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
  };

  outputs = { self, nixpkgs, nixpkgs-master }: {
    nixosConfigurations = {
      satreNixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./hardware-configuration.nix
          ./configuration.nix
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
