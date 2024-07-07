{
    description = "NixOS flake of blackwhite";

    inputs = {
        # NixOS official package source, using the nixos-23.11 branch here
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        catppuccin.url = "github:catppuccin/nix";

        spicetify-nix.url = "github:the-argus/spicetify-nix";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        ...
    } @inputs: {
        nixosConfigurations.yuki = nixpkgs.lib.nixosSystem {
            specialArgs = {
                inherit inputs;
            };

            modules = [
                # Import the previous configuration.nix we used,
                # so the old configuration file still takes effect
                ./hosts/blackwhite

                inputs.catppuccin.nixosModules.catppuccin

                inputs.home-manager.nixosModules.home-manager {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;

                        extraSpecialArgs = {
                            inherit inputs;
                        };

                        users.blackwhite = {
                            imports = [
                                ./home

                                inputs.catppuccin.homeManagerModules.catppuccin
                            ];
                        };
                    };
                }
            ];
        };
    };
}