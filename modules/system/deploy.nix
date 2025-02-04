{
  name,
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib.modules) mkIf mkOptionDefault;
in {
  options = let
    inherit (lib.types) nullOr;
    inherit (lib.options) mkOption;
  in {
    deploy = mkOption {
      type = nullOr (import inputs.arcexprs {}).lib.json.types.attrs;
    };
  };
  config = {
    deploy = let
      nixos = config.built;
    in {
      sshUser = mkOptionDefault "deploy";
      user = mkOptionDefault "root";
      sshOpts = mkIf (config.type == "NixOS") (
        mkOptionDefault ["-p" "${builtins.toString (builtins.head nixos.config.services.openssh.ports)}"]
      );
      autoRollback = mkOptionDefault true;
      magicRollback = mkOptionDefault true;
      fastConnection = mkOptionDefault false;
      hostname = mkOptionDefault "${name}.inskip.me";
      profiles.system = {
        user = "root";
        path = inputs.deploy-rs.lib.${config.system}.activate.nixos inputs.self.nixosConfigurations.${name};
      };
    };
  };
}
