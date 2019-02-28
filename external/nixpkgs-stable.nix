let
  pinnedVersion = builtins.fromJSON (builtins.readFile ./nixpkgs-stable-version.json);
  pinned = builtins.fetchTarball {
    inherit (pinnedVersion) url sha256;
  };

  importPinned = import pinned {
    config = {};
    overlays = [];
  };

  patches = [];

  patched = importPinned.runCommand "nixpkgs-stable-${pinnedVersion.rev}"
    {
      inherit pinned patches;

      preferLocalBuild = true;
    }
    ''
      cp -r $pinned $out
      chmod -R +w $out
      for p in $patches; do
        echo "Applying patch $p";
        patch -d $out -p1 < "$p";
      done
    '';
in
  patched
