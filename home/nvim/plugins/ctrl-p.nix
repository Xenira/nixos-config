{
  config,
  lib,
  pkgs,
  ...
}:

let
  fromGitHub =
    ref: owner: repo: hash:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = pkgs.fetchFromGitHub {
        owner = owner;
        repo = repo;
        rev = ref;
        hash = hash;
      };
    };
in

{
  options.pi.nvim.plugins.ctrl-p.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf config.pi.nvim.plugins.ctrl-p.enable {
    home-manager.users.ls = {
      programs.nixvim = {
        extraPlugins = with pkgs.vimPlugins; [
          (fromGitHub "master" "ctrlpvim" "ctrlp.vim" "sha256-+hzUzH8/BOwmQ2GECafQmJyOTB8QQEk0hyCojD2RU/U=")
        ];

        keymaps = [
          # movement
          {
            mode = [
              "n"
              "v"
              "o"
            ];
            key = "<C-p>";
            action = "<cmd>CtrlPMRU<cr>";
          }
        ];
      };
    };
  };
}
