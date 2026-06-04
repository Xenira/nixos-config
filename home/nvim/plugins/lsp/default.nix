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
    ./jsonls.nix
    ./nixd.nix
    ./perlnavigator.nix
    ./qmlls.nix
    ./sqls.nix
    ./tilt_ls.nix
    ./ts-ls.nix
    ./typos-lsp.nix
    ./volar.nix
  ];

  config = lib.mkIf cfg.enable {
    # TODO:
    # - bashls
    # - biome
    pi.nvim.plugins.lsp = {
      intelephense.enable = lib.mkDefault false;
      nixd.enable = lib.mkDefault true;
      perlnavigator.enable = lib.mkDefault true;
      qmlls.enable = lib.mkDefault true;
      sqls.enable = lib.mkDefault true;
      tilt_ls.enable = lib.mkDefault true;
      ts-ls.enable = lib.mkDefault true;
      typos-lsp.enable = lib.mkDefault true;
      volar.enable = lib.mkDefault false;
      jsonls.enable = lib.mkDefault true;
    };

    home-manager.users.ls = {
      programs.nixvim.plugins = {
        lspconfig.enable = true;
        lsp = {
          enable = true;
          inlayHints = true;

          keymaps.extra = [
            {
              key = "<leader>dj";
              action = "vim.diagnostic.goto_next";
            }
            {
              key = "<leader>dk";
              action = "vim.diagnostic.goto_prev";
            }
            {
              key = "<leader>h";
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
  };
}
