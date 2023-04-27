{ pkgs, ... }:
with pkgs; {
  programs.neovim = {
    extraPackages = [ ripgrep ];
    plugins = with vimPlugins; [
      plenary-nvim
      harpoon
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local n = require("config.keymap").nnoremap

          n("<leader>f", "<CMD>Telescope find_files hidden=true<CR>")
          n("<leader>g", "<CMD>Telescope live_grep<CR>")
          n("<leader>h", "<CMD>Telescope diagnostics<CR>")

          local telescope = require("telescope")
          local actions = require("telescope.actions")

          telescope.setup({
            defaults = {
              prompt_prefix = " ",
              selection_caret = " ",
              path_display = { "truncate" },
              file_ignore_patterns = {
                ".git/",
                "target/",
                "vendor/*",
                "%.lock",
                "%.sqlite3",
                "node_modules/*",
                "%.svg",
                "%.otf",
                "%.ttf",
                "%.webp",
                ".dart_tool/",
                ".gradle/",
                ".idea/",
                ".vscode/",
                "build/",
                "env/",
                "gradle/",
                "node_modules/",
                "%.pdb",
                "%.dll",
                "%.class",
                "%.exe",
                "%.cache",
                "%.ico",
                "%.pdf",
                "%.dylib",
                "%.jar",
                "%.docx",
                "%.met",
                "smalljre_*/*",
                ".vale/",
                "%.burp",
                "%.mp4",
                "%.mkv",
                "%.rar",
                "%.zip",
                "%.7z",
                "%.tar",
                "%.bz2",
                "%.epub",
                "%.flac",
                "%.tar.gz",
              },

              mappings = {
                i = {
                  ["<C-n>"] = actions.cycle_history_next,
                  ["<C-p>"] = actions.cycle_history_prev,

                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous,

                  ["<C-c>"] = actions.close,

                  ["<Down>"] = actions.move_selection_next,
                  ["<Up>"] = actions.move_selection_previous,

                  ["<CR>"] = actions.select_default,
                  ["<C-x>"] = actions.select_horizontal,
                  ["<C-v>"] = actions.select_vertical,
                  ["<C-t>"] = actions.select_tab,

                  ["<C-u>"] = actions.preview_scrolling_up,
                  ["<C-d>"] = actions.preview_scrolling_down,

                  ["<PageUp>"] = actions.results_scrolling_up,
                  ["<PageDown>"] = actions.results_scrolling_down,

                  ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                  ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                  ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                  ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                  ["<C-l>"] = actions.complete_tag,
                  ["<C-_>"] = actions.which_key,
                },

                n = {
                  ["<ESC>"] = actions.close,
                  ["jk"] = actions.close,
                  ["<CR>"] = actions.select_default,
                  ["<C-x>"] = actions.select_horizontal,
                  ["<C-v>"] = actions.select_vertical,
                  ["<C-t>"] = actions.select_tab,

                  ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                  ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                  ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                  ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                  ["j"] = actions.move_selection_next,
                  ["k"] = actions.move_selection_previous,
                  ["H"] = actions.move_to_top,
                  ["M"] = actions.move_to_middle,
                  ["L"] = actions.move_to_bottom,

                  ["<Down>"] = actions.move_selection_next,
                  ["<Up>"] = actions.move_selection_previous,
                  ["gg"] = actions.move_to_top,
                  ["G"] = actions.move_to_bottom,

                  ["<C-u>"] = actions.preview_scrolling_up,
                  ["<C-d>"] = actions.preview_scrolling_down,

                  ["<PageUp>"] = actions.results_scrolling_up,
                  ["<PageDown>"] = actions.results_scrolling_down,

                  ["?"] = actions.which_key,
                },
              },
            },
            pickers = {
              find_files = {
                theme = "dropdown",
                previewer = false,
              },
              live_grep = {
                theme = "dropdown",
              },
              diagnostics = {
                theme = "dropdown",
              },
            },
            extensions = {},
          })

          telescope.load_extension("notify")
        '';
      }
    ];
  };
}