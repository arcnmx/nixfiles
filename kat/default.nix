{
  tree,
  std,
  ...
}: let
  inherit (std) set list;
  wrapImports = imports:
    set.map
    (_: paths: {config, ...}: {
      config.home-manager.users.kat = {
        imports = list.singleton paths;
      };
    })
    imports;
  dirImports = wrapImports tree.prev;
in
  tree.prev
  // {
    common = {
      imports = with tree.prev; [
        base16
        shell
        neovim
      ];
    };
    gui = {
      imports = with dirImports; [
        gui
        wezterm
        gpg
      ];
    };
    work = {
      imports = with dirImports; [
        wezterm
        gpg
      ];
    };
  }
