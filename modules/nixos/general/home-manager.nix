{ lib, ... }:

with lib;

let
  shabka = import <shabka> { };
  release = builtins.getEnv "RELEASE";
in {
  imports = [
    (import "${shabka.external.home-manager."${release}".path}/nixos")
  ];

  options.shabka.home-manager.config = mkOption {
    default = { name, uid, isAdmin, nixosConfig }: {...}: {};
    description = ''
      Function that returns the Home Manager configuration.
    '';
  };

  config = {
    home-manager.useUserPackages = true;
  };
}
