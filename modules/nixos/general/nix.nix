{ config, pkgs, lib, ... }:

with lib;

let

  shabka-path = builtins.toPath ./../../..;

in {
  nix = {
    autoOptimiseStore = true;
    buildCores = 0;
    daemonIONiceLevel = 7;
    daemonNiceLevel = 10;

    extraOptions = ''
      auto-optimise-store = true
    '';

    nixPath = [
      "nixos-config=/etc/nixos/configuration.nix"
      "nixpkgs=/etc/nixpkgs"
      "shabka-path=/etc/shabka"
    ];

    optimise = {
      automatic = true;
      dates = [ "12:00" ];
    };

    binaryCaches = [
      "https://cache.nixos.org/"
      "https://kalbasit.cachix.org"
      "https://yl.cachix.org"
    ];
    binaryCachePublicKeys = [
      "yl.cachix.org-1:Abr5VClgHbNd2oszU+ivr+ujB0Jt2swLo2ddoeSMkm0="
    ];
    trustedUsers = [ "root" "@wheel" ];

    useSandbox = true;

    distributedBuilds = true;
  };
}
