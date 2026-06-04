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
    ./actions-preview.nix
    ./auto-session.nix
    ./barbecue.nix
    ./ccc.nix
    ./cmp.nix
    ./comment-box.nix
    ./comment.nix
    ./conform-nvim.nix
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
    ./lsp
    ./lsp-signature.nix
    ./lspkind.nix
    ./luasnip
    ./markdown-preview.nix
    ./neogit.nix
    ./neotest.nix
    ./nix.nix
    ./nvim-surround.nix
    ./nvim-tree.nix
    ./overseer.nix
    ./rustaceanvim.nix
    ./smear-cursor.nix
    ./telescope.nix
    ./treesitter.nix
    ./trouble.nix
    ./vim-airline.nix
    ./vimwiki.nix
    ./web-devicons.nix
    ./which-key.nix
    ./wilder.nix
  ];

  config = lib.mkIf config.pi.nvim.plugins.enable {
    pi.nvim.plugins = {
      actions-preview.enable = lib.mkDefault true;
      auto-session.enable = lib.mkDefault true;
      barbecue.enable = lib.mkDefault true;
      ccc.enable = lib.mkDefault true;
      cmp.enable = lib.mkDefault true;
      comment-box.enable = lib.mkDefault true;
      comment.enable = lib.mkDefault true;
      conform-nvim.enable = lib.mkDefault true;
      copilot-lua.enable = lib.mkDefault true;
      coverage.enable = lib.mkDefault true;
      ctrl-p.enable = lib.mkDefault true;
      cursorline.enable = lib.mkDefault true;
      dap-ui.enable = lib.mkDefault true;
      dap.enable = lib.mkDefault true;
      diffview.enable = lib.mkDefault true;
      gitblame.enable = lib.mkDefault true;
      gitsigns.enable = lib.mkDefault true;
      leap.enable = lib.mkDefault true;
      lsp-signature.enable = lib.mkDefault true;
      lsp.enable = lib.mkDefault true;
      lspkind.enable = lib.mkDefault true;
      luasnip.enable = lib.mkDefault true;
      markdown-preview.enable = lib.mkDefault true;
      neogit.enable = lib.mkDefault true;
      neotest.enable = lib.mkDefault true;
      nix.enable = lib.mkDefault true;
      nvim-surround.enable = lib.mkDefault true;
      nvim-tree.enable = lib.mkDefault true;
      overseer.enable = lib.mkDefault true;
      rustaceanvim.enable = lib.mkDefault true;
      smear-cursor.enable = lib.mkDefault true;
      telescope.enable = lib.mkDefault true;
      treesitter.enable = lib.mkDefault true;
      trouble.enable = lib.mkDefault true;
      vim-airline.enable = lib.mkDefault true;
      vimwiki.enable = lib.mkDefault true;
      web-devicons.enable = lib.mkDefault true;
      which-key.enable = lib.mkDefault true;
      wilder.enable = lib.mkDefault true;
    };
  };
}
