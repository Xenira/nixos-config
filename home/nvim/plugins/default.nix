{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.pi.nvim.plugins = {
    enable = lib.mkEnableOption "Enable Neovim plugins configuration";
  };

  imports = [
    ./lsp
    ./luasnip
    ./actions-preview.nix
    ./auto-session.nix
    ./barbecue.nix
    ./ccc.nix
    ./cmp.nix
    ./comment-box.nix
    ./comment.nix
    ./copilot-lua.nix
    ./coverage.nix
    ./ctrl-p.nix
    ./cursorline.nix
    ./dap-ui.nix
    ./dap.nix
    ./diffview.nix
    ./gitblame.nix
    ./gitsigns.nix
    ./leap.nix
    ./lsp-signature.nix
    ./lspkind.nix
    ./markdown-preview.nix
    ./neogit.nix
    ./nix.nix
    ./nvim-surround.nix
    ./nvim-tree.nix
    ./rustaceanvim.nix
    ./smear-cursor.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./vim-airline.nix
    ./web-devicons.nix
    ./which-key.nix
    ./wilder.nix
  ];

  config = lib.mkIf config.pi.nvim.plugins.enable {
    pi.nvim.plugins = {
      lsp.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      luasnip.enable = lib.mkDefault config.pi.nvim.plugins.enable;

      actions-preview.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      auto-session.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      barbecue.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      ccc.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      cmp.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      comment-box.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      comment.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      copilot-lua.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      coverage.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      ctrl-p.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      cursorline.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      dap-ui.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      dap.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      diffview.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      gitblame.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      gitsigns.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      leap.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      lsp-signature.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      lspkind.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      markdown-preview.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      neogit.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      nix.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      nvim-surround.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      nvim-tree.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      rustaceanvim.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      smear-cursor.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      telescope.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      treesitter.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      trouble.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      vim-airline.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      web-devicons.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      which-key.enable = lib.mkDefault config.pi.nvim.plugins.enable;
      wilder.enable = lib.mkDefault config.pi.nvim.plugins.enable;
    };
  };
}
