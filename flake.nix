{
  description = "lstuma's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, utils, home-manager, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      nixosModules = {
        system = import ./system/configuration.nix;
      };

      channels.nixpkgs.overlaysBuilder = channels: [
        (final: prev: {
          master = inputs.nixpkgs-master.legacyPackages.${prev.system};
        })
      ];

      channelsConfig.allowUnfree = true;
      hosts."lstuma-nix" = {
        system = "x86_64-linux";
      	modules = [
	        self.nixosModules.system
          inputs.stylix.nixosModules.stylix
	        home-manager.nixosModules.home-manager
	        {
	          home-manager.useGlobalPkgs = true;
	          home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
	          home-manager.users.lstuma = import ./hm/home.nix;
	          home-manager.extraSpecialArgs = { inherit inputs; };
	        }
	      ];
      };
    };
}
