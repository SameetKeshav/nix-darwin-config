{ ... }: {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "sameetkeshav";
    homeDirectory = "/Users/sameetkeshav";
    packages = [ ];
  };
  programs.home-manager.enable = true;
}