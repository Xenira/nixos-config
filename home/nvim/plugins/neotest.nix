{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.pi.nvim.plugins.neotest;
  nvo = [
    "n"
    "v"
    "o"
  ];
in
{
  options.pi.nvim.plugins.neotest = {
    enable = lib.mkEnableOption "Enable Neotest plugin";
  };
  config = lib.mkIf cfg.enable {
    home-manager.users.ls = {
      programs.nixvim = {
        keymaps = [
          {
            mode = nvo;
            key = "<leader>nr";
            action = ''<cmd>lua require("neotest").run.run()<cr>'';
            options = {
              desc = "Neotest: Run nearest test";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>nf";
            action = ''<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>'';
            options = {
              desc = "Neotest: Run all tests in current file";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>na";
            action = ''<cmd>lua require("neotest").run.run({ suite = true })<cr>'';
            options = {
              desc = "Neotest: Run all tests in project";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>nd";
            action = ''<cmd>lua require("neotest").run.run({ strategy = "dap" })<cr>'';
            options = {
              desc = "Neotest: Debug nearest test";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>ns";
            action = ''<cmd>lua require("neotest").run.stop()<cr>'';
            options = {
              desc = "Neotest: Stop test";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>nn";
            action = ''<cmd>lua require("neotest").run.attach()<cr>'';
            options = {
              desc = "Neotest: Attach to nearest test";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>no";
            action = ''<cmd>lua require("neotest").output.open()<cr>'';
            options = {
              desc = "Neotest: Show test output";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>np";
            action = ''<cmd>lua require("neotest").output_panel.toggle()<cr>'';
            options = {
              desc = "Neotest: Toggle output panel";
              unique = true;
            };
          }
          {
            mode = nvo;
            key = "<leader>nv";
            action = ''<cmd>lua require("neotest").summary.toggle()<cr>'';
            options = {
              desc = "Neotest: Toggle summary";
              unique = true;
            };
          }
        ];

        plugins.neotest = {
          enable = true;
          adapters = {
            bash.enable = true;
            # playwright.enable = true;
            plenary.enable = true;
            rust.enable = true;
            vitest.enable = false; # Non free
            phpunit = {
              enable = true;
              settings = {
                root_files = [
                  "phpunit.xml"
                  "composer.json"
                  "app/composer.json"
                  "app/phpunit.xml"
                  ".gitignore"
                ];
                root_ignore_files = [
                  ".nvim.toml"
                ];
                filter_dirs = [
                  "vendor"
                  ".git"
                  "node_modules"
                  "target"
                ];
                phpunit_cmd.__raw = ''
                  function()
                    cwd = vim.fn.getcwd()
                    if vim.uv.fs_stat(cwd .. "/vendor/bin/phpunit") then
                      return cwd .. "/vendor/bin/phpunit"
                    end

                    if vim.uv.fs_stat(cwd .. "/tools/phpunit") then
                      return cwd .. "/tools/phpunit"
                    end

                    if vim.uv.fs_stat(cwd .. "/app/vendor/bin/phpunit") then
                      return cwd .. "/vendor/bin/phpunit"
                    end

                    if vim.uv.fs_stat(cwd .. "/app/tools/phpunit") then
                      return cwd .. "/tools/phpunit"
                    end

                    return "phpunit"
                  end
                '';
              };
            };
          };
          settings = {
            summary = {
              open = "botright split | resize 33";
            };
            status = {
              virtual_text = true;
            };
          };
        };

        plugins.nvim-dap.enable = true;
        plugins.plenary.enable = true;
      };
    };
  };
}
