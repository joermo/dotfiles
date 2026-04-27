{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Pin specific versions
    nixpkgs-neovim.url = "github:nixos/nixpkgs/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f"; # neovim 0.11.2, 0.12.* broke treesitter; TODO fix this
  };

  outputs = {nixpkgs, ...} @ inputs:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; }; # inputs = inputs
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
            # Use an overlay to replace the default Neovim with the pinned one
            nixpkgs.overlays = [
              (final: prev: {
                neovim = inputs.nixpkgs-neovim.legacyPackages.${pkgs.system}.neovim;
              })
            ];
        })
      ];
    };
  };
}
