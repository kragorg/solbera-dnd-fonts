{
  description = "Free Creative Commons clones of the fonts used in D&D 5th Edition";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  # The fonts live in the repository root, while this flake lives in ./nix.
  # Locally `nix build ./nix` just works: Nix finds the enclosing git repo and
  # uses it as the flake root (with dir=nix), so `src = ../.` in package.nix
  # resolves inside the flake tree. A remote ref must spell out the
  # subdirectory, since the repo root has no flake.nix:
  #   nix build 'github:kragorg/solbera-dnd-fonts?dir=nix'
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        solbera-dnd-fonts = pkgs.callPackage ./package.nix { };
      in
      {
        packages = {
          inherit solbera-dnd-fonts;
          default = solbera-dnd-fonts;
        };
      }
    );
}
