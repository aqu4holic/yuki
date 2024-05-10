{
    description = "NixOS flake of blackwhite";

    inputs = {
        # NixOS official package source, using the nixos-23.11 branch here
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
            specialArgs = {inherit inputs;};
            modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./hosts/blackwhite

                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.blackwhite = import ./home;

                    # Optionally, use home-manager.extraSpecialArgs to pass
                    # arguments to home.nix
                }
            ];
        };
    };
}