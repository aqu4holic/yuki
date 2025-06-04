{
    description = "NixOS flake of blackwhite";

    inputs = {
        # NixOS official package source, using the nixos-23.11 branch here
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

        catppuccin.url = "github:catppuccin/nix";
        zen-browser.url = "github:aqu4holic/zen-browser-flake";
        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
        spicetify-nix.url = "github:Gerg-L/spicetify-nix";

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {
        self,
        nixpkgs,
        zen-browser,
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
                inputs.nix-flatpak.nixosModules.nix-flatpak
                # inputs.zen-browser.nixosModules.zen-browser

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

                                inputs.catppuccin.homeModules.catppuccin
                                inputs.spicetify-nix.homeManagerModules.default
                                # inputs.zen-browser.homeManagerModules.zen-browser
                                inputs.nix-flatpak.homeManagerModules.nix-flatpak
                            ];
                        };
                    };
                }
            ];
        };
    };
}
