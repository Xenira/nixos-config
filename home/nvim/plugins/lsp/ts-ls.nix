{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pi.nvim.plugins.lsp.ts-ls.enable = lib.mkEnableOption "Enable TypeScript Language Server";

  config = lib.mkIf config.pi.nvim.plugins.lsp.ts-ls.enable {
    home-manager.users.ls = {
      programs.nixvim.plugins.lsp = {
        servers = {
          ts_ls = {
            enable = true;
            settings = {
              typescript = {
                inlayHints = {
                  includeInlayParameterNameHints = "all";
                  includeInlayParameterNameHintsWhenArgumentMatchesName = true;
                  includeInlayFunctionParameterTypeHints = true;
                  includeInlayVariableTypeHints = true;
                  includeInlayVariableTypeHintsWhenTypeMatchesName = true;
                  includeInlayPropertyDeclarationTypeHints = true;
                  includeInlayFunctionLikeReturnTypeHints = true;
                  includeInlayEnumMemberValueHints = true;
                };
              };
            };
          };
        };
      };
    };
  };
}
