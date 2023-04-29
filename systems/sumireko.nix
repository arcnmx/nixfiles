_: let
  hostConfig = {
    tree,
    pkgs,
    ...
  }: {
    imports = with tree; [
      kat.work
      darwin.distributed
    ];

    security.pam.enableSudoTouchIdAuth = true;

    distributed.systems.renko.preference = 5;

    environment.systemPackages = with pkgs; [
      fd # fd, better fine!
      ripgrep # rg, better grep!
      deadnix # dead-code scanner
      alejandra # code formatter
      statix # anti-pattern finder
      deploy-rs.deploy-rs # deployment system
      rnix-lsp # vscode nix extensions
      terraform # terraform
    ];

    homebrew = {
      brewPrefix = "/opt/homebrew/bin";
      brews = [
        "gnupg"
        "pinentry-mac"
        "awscurl"
        "pandoc"
        "helm"
      ];
      casks = [
        "utm"
        "discord"
        "barrier"
        "mullvadvpn"
        "bitwarden"
        "deluge"
        "telegram-desktop"
        "spotify"
        "element"
        "signal"
        "brave-browser"
        "disk-inventory-x"
        "dozer"
        "devtoys"
        "cyberduck"
        "docker"
        "pycharm-ce"
        "slack"
        "boop"
        "obsidian"
        "contexts"
        "rectangle"
      ];
      taps = [
        "pulumi/tap"
      ];
      masApps = {
        Tailscale = 1475387142;
        Dato = 1470584107;
        Lungo = 1263070803;
        "Battery Indicator" = 1206020918;
      };
    };

    system.stateVersion = 4;
  };
in {
  arch = "aarch64";
  type = "macOS";
  modules = [
    hostConfig
  ];
}
