{ config, lib, pkgs, ... }:

let
  base_cfg = config.pi.nvim.plugins;
  cfg = base_cfg.cmp;
  luasnip = base_cfg.luasnip;
in {
  options.pi.nvim.plugins.cmp.enable = lib.mkEnableOption "Enable Plugin";

  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; group_index = 2; }
          { name = "buffer"; group_index = 2; }
          { name = "clippy"; group_index = 2; }
        ] ++ lib.optionals luasnip.enable [
          { name = "luasnip"; group_index = 2; }
        ];
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        };
        formatting.format = lib.mkForce ''
          function(entry, vim_item)
            if vim.tbl_contains({ "path" }, entry.source.name) then
              local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon
                vim_item.kind_hl_group = hl_group
                return vim_item
              end
            end
            return require("lspkind").cmp_format({ with_text = false })(entry, vim_item)
          end
        '';
      };
    };
    cmp-buffer.enable = true;
    cmp-clippy.enable = true;
    cmp-dap.enable = true;
    cmp-omni.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-nvim-lsp-document-symbol.enable = true;
    cmp-nvim-lsp-signature-help.enable = true;
    cmp-dictionary.enable = true;
    cmp_luasnip.enable = lib.mkDefault luasnip.enable;
  };
    };
  };
}
