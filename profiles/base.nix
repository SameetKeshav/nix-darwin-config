{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  ids.gids.nixbld = lib.mkForce 350;
  system.stateVersion = 4;
}