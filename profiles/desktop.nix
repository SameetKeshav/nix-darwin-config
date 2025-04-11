{ config, pkgs, lib, ... }:
{
  imports = [
    ./base.nix
    ../config/homebrew.nix
    # (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz}" { pkgs = pkgs; lib = lib; config = config; })
    # ../config/aerospace.nix
    # ../config/sketchybar.nix
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Dev
    awscli2
    docker
    docker-compose
    pipx
    fnm
    git
    vim
    mkalias
    colima

    # Mac Utilities
    mas
    lsd
    wget
    btop
    zoxide
    hydra-check
    zsh-powerlevel10k

    # Tools
    chezmoi
    tldr
    fzf
    stow
    zsh-autosuggestions
    zsh-nix-shell
    zsh-syntax-highlighting
  ];

  users.users.sameetkeshav = {
    name = "sameetkeshav";
    home = "/Users/sameetkeshav";
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.sameetkeshav = {
    home.stateVersion = "22.05";

    imports = [
      # ../config/home-manager/vscode/default.nix
      ../config/home-manager/zsh/default.nix
    ];
  };

  homebrew = {
    
    brews = [
      "jenv"
      # "docker-completion"
    ];

    casks = [
      # Browsers
      "arc"
      "google-chrome"

      # Collab & Messaging
      "discord"
      "slack"
      "zoom"

      # Dev
      "ghostty"
      "warp"
      "iterm2"
      "android-studio"
      "insomnia"
      "gitkraken"
      "visual-studio-code"
      "zed"
      "apache-directory-studio"
      "another-redis-desktop-manager"
      "dbeaver-community"
      "nosql-workbench"

      # Drivers etc.
      "logi-options+"
      # "logitech-options"

      # Graphics
      "blender"
      "figma"

      # Mac Utilities
      # "hiddenbar"
      "raycast"
      "betterdisplay"

      # Media
      "spotify"
      "tidal"
      "multiviewer-for-f1"

      # Office
      "obsidian"
      "adobe-acrobat-reader"
      "microsoft-office"

      # Tools
      "appcleaner"
      "lastpass"
      "the-unarchiver"

      # apple default fonts
      # "font-sf-pro"
      # "sf-symbols"
    ];

    masApps = {
      "Command X" = 6448461551;
      "TestFlight" = 899247664;
      "Bitwarden" = 1352778147;
      "Toggl Track" = 1291898086;
      "MIT Atlas" = 1498222646;
    };
  };
}