{
	description="NixOS";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		minegrub-world-sel-theme = {
			url = "github:Lxtharia/minegrub-world-sel-theme";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		
		noctalia = {
			url = "github:noctalia-dev/noctalia";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		spicetify-nix = {
			url = "github:Gerg-L/spicetify-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		catppuccin = {
			url = "github:catppuccin/nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, home-manager, noctalia, spicetify-nix, catppuccin, ... }: {
		nixosConfigurations.nixos-btw = nixpkgs.lib.nixosSystem {
			specialArgs = { inherit inputs; };
			system = "x86_64-linux";
			modules = [
				inputs.minegrub-world-sel-theme.nixosModules.default
				./noctalia.nix
				./configuration.nix
				home-manager.nixosModules.home-manager {
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						extraSpecialArgs = { inherit inputs; };
						users.gui = {
							imports = [
								./home.nix
								catppuccin.homeModules.catppuccin
							];
						};
						backupFileExtension = "backup";
					};
				}
			];
		};
	};
}
