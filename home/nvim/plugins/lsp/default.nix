{
  lib,
  config,
  pkgs,
  ...
}:

let
  cfg = config.pi.nvim.plugins.lsp;
in
{
  options.pi.nvim.plugins.lsp.enable = lib.mkEnableOption "Enable LSP Plugins";
  imports = [
    ./intelephense.nix
    ./nixd.nix
    ./sqls.nix
    ./ts-ls.nix
    ./typos-lsp.nix
    ./volar.nix
  ];

  config = lib.mkIf cfg.enable {
    pi.nvim.plugins.lsp = {
      intelephense.enable = lib.mkDefault cfg.enable;
      nixd.enable = lib.mkDefault cfg.enable;
      sqls.enable = lib.mkDefault cfg.enable;
      ts-ls.enable = lib.mkDefault cfg.enable;
      typos-lsp.enable = lib.mkDefault cfg.enable;
      volar.enable = lib.mkDefault cfg.enable;
    };

    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        enable = true;
        keymaps.extra =
          [
            {
              key = "<leader>dj";
              action = "vim.diagnostic.goto_next";
            }
            {
              key = "<leader>dk";
              action = "vim.diagnostic.goto_prev";
            }
            {
              key = "<C-h>";
              action = "vim.lsp.buf.signature_help";
            }
          ]
          ++ lib.optionals config.pi.nvim.plugins.telescope.enable [
            {
              key = "gd";
              action = "<cmd>Telescope lsp_definitions<cr>";
            }
            {
              key = "gr";
              action = "<cmd>Telescope lsp_references<cr>";
            }
            {
              key = "gi";
              action = "<cmd>Telescope lsp_implementations<cr>";
            }
            {
              key = "gt";
              action = "<cmd>Telescope lsp_type_definitions<cr>";
            }
            {
              key = "<leader>df";
              action = "<cmd>Telescope diagnostics<cr>";
            }
          ];
      };
    };
  };
}
