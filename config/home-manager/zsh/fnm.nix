{ config, pkgs, lib, ... }:
let
  fnmInstallScript = ''
    eval "$(fnm env)"
    for version in ${lib.concatStringsSep " " config.programs.fnm.versions}; do
      if ! fnm list | grep -q $version; then
        fnm install --arch x64 $version
      fi
    done
    fnm default ${config.programs.fnm.defaultVersion}
  '';

  fnmRemoveScript = '' 
    for version in $(fnm list | awk '{for (i=1; i<=NF; i++) if ($i ~ /^v[0-9]+\.[0-9]+\.[0-9]+$/) print substr($i, 2)}'); do
      if [[ ! " ${lib.concatStringsSep " " config.programs.fnm.versions} " =~ " $version " ]]; then
        fnm uninstall $version
      fi
    done
  '';
in
{
  options.programs.fnm = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable fnm (Fast Node Manager)";
    };
    versions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = ["18.20.6" "20.19.0"];
      description = "List of Node.js versions to install with fnm";
    };
    defaultVersion = lib.mkOption {
      type = lib.types.str;
      default = "18.20.6";
      description = "Default Node.js version to set with fnm";
    };
  };

  config = lib.mkIf config.programs.fnm.enable {
    home.packages = [ pkgs.fnm ];

    home.activation = {
      fnm = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ${fnmInstallScript}
        ${fnmRemoveScript}
      '';
    };

    programs.zsh.initExtra = ''
      eval "$(fnm env)"
    '';
  };
}