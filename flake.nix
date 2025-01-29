{
  description = "lstuma's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    utils.url = "github:gytis-ivaskevicius/flake-utils-plus";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, utils, home-manager, ... }:
    utils.lib.mkFlake {
      inherit self inputs;

      nixosModules = {
        system = import ./system/configuration.nix;
      };

      
      channelsConfig.allowUnfree = true;
      hosts."lstuma-nix" = {
        system = "x86_64-linux";
      	modules = [
	        self.nixosModules.system
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
