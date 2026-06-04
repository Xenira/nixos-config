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
      nixfmt
      asciidoctor-with-extensions
      kdePackages.qtdeclarative
      phpantom-lsp
      # sonarlint-ls
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
          # formatter-nvim
          sonarlint-nvim
          async-vim
          # nvim-lsp-file-operations
          (fromGitHub "main" "chrisgrieser" "nvim-lsp-endhints"
            "sha256-RstC7vzBNkGtd7XohTQA6PrIc2etzFOPK/NBuC9eGrU="
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
            event = "BufWritePre";
            group = "FormatAutoGroup";
            pattern = "";
            callback.__raw = ''
              function(args)
                require("conform").format({ bufnr = args.buf })
              end'';
          }
          {
            command = "lua vim.diagnostic.open_float(nil, { focusable = false })";
            event = "CursorHold";
          }
        ];
        extraConfigLua = ''
          -- require('lspconfig').phpantom.setup({})
          vim.lsp.config['phpantom'] = {
            cmd = { 'phpantom_lsp' },
            filetypes = { 'php' },
            root_markers = { 'composer.json', '.git' },
          }
          vim.lsp.enable('phpantom')

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
