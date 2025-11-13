{
  pkgs,
  lib,
  config,
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

  importFiles =
    path:
    let
      files = builtins.readDir path;
    in
    let
      fileMap = builtins.mapAttrs (
        file: type:
        if type == "regular" && builtins.match ".*\\.lua" file != null then
          (builtins.readFile "${path}/${file}")
        else if type == "directory" then
          (importFiles "${path}/${file}")
        else
          ""
      ) files;
    in
    builtins.foldl' (acc: curr: acc + curr) "" (builtins.attrValues fileMap);

  nvo = [
    "n"
    "v"
    "o"
  ];
in
{
  imports = [
    ./plugins
  ];

  config = lib.mkIf config.pi.nvim.enable {
    pi.nvim.plugins.enable = true;

    users.users.ls.packages = with pkgs; [
      nixfmt-rfc-style
      asciidoctor-with-extensions
      sonarlint-ls
    ];

    home-manager.users.ls = {
      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        # vimdiffAlias = true;

        clipboard = {
          register = "unnamedplus";
        };
        globals = {
          mapleader = ",";
          maplocalleader = ",";
        };
        opts = {
          termguicolors = true;
          completeopt = [
            "menuone"
            "noselect"
            "noinsert"
          ];
          shortmess.c = true;
          relativenumber = true;
          number = true;
          tabstop = 1;
          softtabstop = 1;
          expandtab = true;
          smartindent = true;
          autoindent = true;
          list = true;
          listchars = "space:·,tab:>~";
          undofile = true;
        };
        filetype.pattern = {
          # Match templ files. Needs custom handling if extension is not equal to the filetype
          ".*/.*\.(%a+)/.*\.templ".__raw = ''
            function(path, bufnr, ext)
                      return ext
                    end'';
        };
        editorconfig.enable = true;
        colorschemes.catppuccin = {
          enable = true;
          settings = {
            flavour = "mocha";
          };
        };
        colorschemes.nightfox = {
          enable = false;
          flavor = "nightfox";
          settings = {
            transparent = true;
          };
        };
        diagnostic.settings = {
          virtual_text = {
            prefix = "";
            severity = [ "error" ];
            signs = true;
            update_in_insert = true;
            underline = true;
            severity_sort = false;
            float = {
              border = "rounded";
              source = "always";
              header = "";
              prefix = "";
            };
          };
        };

        keymaps = [
          # movement
          {
            mode = nvo;
            key = "f";
            action = "h";
          }
          {
            mode = nvo;
            key = "h";
            action = "l";
          }
          {
            mode = nvo;
            key = "p";
            action = "k";
          }
          {
            mode = nvo;
            key = "d";
            action = "j";
            options.nowait = true;
          }
          {
            mode = nvo;
            key = "l";
            action = "d";
          }
          {
            mode = nvo;
            key = "j";
            action = "p";
          }
          {
            mode = nvo;
            key = "k";
            action = "f";
          }
          # actions
          {
            mode = nvo;
            key = "<leader>a";
            action = ''<cmd>lua require("actions-preview").code_actions()<cr>'';
          }
        ];

        extraPlugins = with pkgs.vimPlugins; [
          # lsp-zero-nvim
          formatter-nvim
          sonarlint-nvim
          async-vim
          # nvim-lsp-file-operations
          (fromGitHub "main" "chrisgrieser" "nvim-lsp-endhints"
            "sha256-nRL3ReIBHuOZn09tjlIL6C2Zlj7oooUTPtrjKPUDTJc="
          )
          (fromGitHub "master" "kenn7" "vim-arsync" "sha256-OQ5XDFyyiAD9Oqxv9+x1hMNH4LscKiLzBapmB4ZvOw4=")
          # (fromGitHub "main" "harrisoncramer" "gitlab.nvim" "sha256-kW5Xw9WdGrUcTRiarUc3J1QETJEi32Vr9PixtLAmXU0=")
          # (fromGitHub "main" "harrisoncramer/gitlab-issues.nvim")
          # (fromGitHub "main" "ta-tikoma" "php.easy.nvim" "sha256-O6ju1b7LDnzjmEC7Wz8OUGaw8G0pH37U11Ynn/40JFk=")
        ];

        autoGroups = {
          FormatAutoGroup.clear = false;
        };
        autoCmd = [
          {
            command = "FormatWrite";
            event = "BufWritePost";
            group = "FormatAutoGroup";
          }
          {
            command = "lua vim.diagnostic.open_float(nil, { focusable = false })";
            event = "CursorHold";
          }
        ];
        extraConfigLua = ''
          local util = require("formatter.util")
          local defaults = require("formatter.defaults")

          local prettierd = function()
            return {
              exe = 'PRETTIERD_DEFAULT_CONFIG="~/.config/.prettierrc.json" prettierd',
              args = { util.escape_path(util.get_current_buffer_file_path()) },
              stdin = true,
            }
          end

          -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
          require("formatter").setup({
            -- Enable or disable logging
            logging = false,
            -- Set the log level
            log_level = vim.log.levels.DEBUG,
            -- All formatter configurations are opt-in
            filetype = {
              php = { require("formatter.filetypes.php").php_cs_fixer },
              js = { prettierd },
              typescript = { prettierd },
              json = { require("formatter.filetypes.json").prettierd },
              scss = { require("formatter.filetypes.css").prettierd },
              yaml = { require("formatter.filetypes.yaml").prettierd },
              -- twig = { function ()
              -- return defaults.prettier("html")
              -- end
              -- },
              -- html = { require("formatter.filetypes.html").tidy },
              rust = {
                function()
                  return {
                    exe = "rustfmt",
                    args = {
                      "--edition=2018",
                    },
                    stdin = true,
                  }
                end,
              },
              lua = { require("formatter.filetypes.lua").stylua },
              nix = { require("formatter.filetypes.nix").nixfmt },
              -- vue = { prettierd },
              ["*"] = { require("formatter.filetypes.any").remove_trailing_whitespace },
            },
          })

          require('sonarlint').setup({
            server = {
              cmd = {
                   "sonarlint-ls",
                   "-stdio",
                },
            },
            filetypes = {
              "php",
              "dockerfile",
              "javascript",
              "typescript",
              "python",
              "java",
              "cs",
              "rust",
              "cpp",
            },
          })

          vim.treesitter.query.set("php", "highlights", [[; extends
            (member_call_expression
              name: (name) @fnName (#match? @fnName "^addSql$")
              arguments: (arguments
                (argument
                  (string) @string (#set! "priority" 90)
                )
              )
            )
          ]])
          vim.treesitter.query.set("php", "injections", [[
            (member_call_expression
              name: (name) @fnName (#match? @fnName "^addSql$")
              arguments: (arguments
                (argument
                  (string [(string_content)] @injection.content
                    (#set! injection.language "sql")
                    (#set! injection.combined)
                  )
                )
              )
            )
          ]])
        '';
      };
    };
  };
}
