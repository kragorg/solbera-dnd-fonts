{ lib, stdenvNoCC }:

stdenvNoCC.mkDerivation {
  pname = "solbera-dnd-fonts";
  version = "unstable-2024-01-01";

  # The fonts live in the repository root. This flake is meant to be evaluated
  # with the repo root as the flake root (e.g. `nix build .?dir=nix`), so `../.`
  # stays inside the flake tree.
  src = ../.;

  # These are pre-built OpenType fonts: nothing to configure or build.
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    find . -name '*.otf' -exec install -Dm644 -t "$out/share/fonts/opentype" {} +

    runHook postInstall
  '';

  meta = {
    description = "Free Creative Commons clones of the fonts used in D&D 5th Edition";
    longDescription = ''
      A collection of 22 OpenType fonts in 7 families recreating the typefaces
      used in base D&D 5th Edition, originally created by Solbera with later
      fixes and additions by Ryrok, Ners and LUCASTUCIOUS. The families are
      Bookinsanity, Scaly Sans, Scaly Sans Caps, Nodesto Caps Condensed,
      Mr Eaves Small Caps, Zatanna Misdirection, Solbera Imitation and
      Dungeon Drop Case.
    '';
    homepage = "https://github.com/kragorg/solbera-dnd-fonts";
    license = lib.licenses.cc-by-sa-40;
    platforms = lib.platforms.all;
  };
}
