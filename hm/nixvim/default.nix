{ lib, config, pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
      };
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
        };
        folding = false;
        nixvimInjections = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
      };
      illuminate = {
        enable = true;
        underCursor = false;
        filetypesDenylist = [
          "Outline"
          "TelescopePrompt"
          "alpha"
          "harpoon"
          "reason"
        ];
      };
      neo-tree = {
        enable = true;
        sources = [
          "filesystem"
          "buffers"
          "document_symbols"
        ];
        addBlankLineAtTop = false;
        filesystem = {
          bindToCwd = false;
          followCurrentFile = {
            enabled = false;
          };
        };
        defaultComponentConfigs = {
          indent = {
            withExpanders = true;
            expanderCollapsed = "󰅂";
            expanderExpanded = "󰅀";
            expanderHighlight = "NeoTreeExpander";
          };
        };
        window = {
          width = 30;
        };
      };
      navic = {
        enable = true;
        settings = {
          separator = "  ";
          highlight = true;
          depthLimit = 5;
          lsp = {
            autoAttach = true;
          };
          icons = {
            Array = "󱃵  ";
            Boolean = "  ";
            Class = "  ";
            Constant = "  ";
            Constructor = "  ";
            Enum = " ";
            EnumMember = " ";
            Event = " ";
            Field = "󰽏 ";
            File = " ";
            Function = "󰡱 ";
            Interface = " ";
            Key = "  ";
            Method = " ";
            Module = "󰕳 ";
            Namespace = " ";
            Null = "󰟢 ";
            Number = " ";
            Object = "  ";
            Operator = " ";
            Package = "󰏖 ";
            String = " ";
            Struct = " ";
            TypeParameter = " ";
            Variable = " ";
          };
        };
      };
      web-devicons = {
        enable = true;
      };
      transparent = {
        enable = true;
      };
      bufferline = {
        enable = true;
        settings = {
          options = {
            diagnostics = "nvim_lsp";
            mode = "buffers";

            close_icon = "󰅚 ";
            buffer_close_icon = " ";
            modified_icon =" ";

            show_buffer_icons = true;
            show_buffer_close_icons = true;
            show_close_icon = true;
            show_tab_indicators = true;
            
            seperator_style = "thin";
            enfore_regular_tabs = false;
            always_show_bufferline = true;

            offsets = [
              {
                filetype = "neo-tree";
                text = "Neo-tree";
                highlight = "Directory";
                text_align = "left";
              }
              {
                filetype = "copilot-chat";
                text = "Copilot Chat";
                highlight = "Directory";
                text_align = "left";
              }
              {
                filetype="copilot-panel";
                text = "Copilot Panel";
                highlight = "Directory";
                text_align = "left";
              }
            ];
          };
        };
      };
      guess-indent = {
        enable = true;
      };
      indent-blankline = {
        enable = true;
        settings = {
          indent = {
            char = "│";
          };
        };
      };
      copilot-lua = {
        enable = true;
        settings = {
          suggestion = {
            enabled = true;
          };
          panel = {
            enabled = true;
          };
        };
      };
      copilot-chat = {
        enable = true;
        settings = {
          auto_follow_cursor = false;
          window = {
            width = 70;
          };
        };
      };
      cmp = {
        enable = true;
        settings = {
          autoEnableSources = true;
          sources =  [
            { name = "emoji"; }
            { name = "nvim_lsp"; }
            { name = "copilot"; }
            { 
              name = "path";
              keywordLength = 3;
            }
          ];
        };
      };
      cmp-emoji = {
        enable = true;
      };
      cmp-nvim-lsp = {
        enable = true;
      };
      cmp-path = {
        enable = true;
      };
      copilot-cmp = {
        enable = true;
      };
    };
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };
    opts = {
      number = true;
    };
    extraConfigLua = ''
      function wrap_right()
        local col = vim.fn.col('.')
        local line = vim.fn.getline('.')
        if col-1 >= #line then
          return 'j0'
        else
          return '<Right>'
        end
      end
      function wrap_left()
        local col = vim.fn.col('.')
        if col == 1 then
          return 'k$'
        else
          return '<Left>'
        end
      end
      '';
    keymaps = [
      {
        mode = ["n", "v"];
        key = "<Left>";
        action = "v:lua.wrap_left()";
        options = {
          expr = true;
          noremap = true;
        };
      }
      {
        mode = ["i", "n", "v"];
        key = "<Right>";
        action = "v:lua.wrap_right()";
        options = {
          expr = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle Neo-tree file explorer";
        };
      }
      {
        mode = "n";
        key = "<C-w><C-Left>";
        action = "<cmd>Neotree toggle<cr><C-w>H<cmd>Neotree toggle<cr>";
        options = {
          desc = "Move window to left";
        };
      }
      {
        mode = "n";
        key = "<C-w><C-Right>";
        action = "<cmd>Neotree toggle<cr><C-w>L<cmd>Neotree toggle<cr>";
        options = {
          desc = "Move window to right";
        };
      }
      {
        mode = "n";
        key = "<C-w><C-+>";
        action = "<cmd>vert resize +8<cr>";
        options = {
          desc = "Horizontally upsize window";
        };
      }
      {
        mode = "n";
        key = "<C-w><C-->";
        action = "<cmd>vert resize -8<cr>";
        options = {
          desc = "Horizontally downsize window";
        };
      }
      {
        mode = "n";
        key = "<leader>n";
        action = "<cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Cycle to next buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>p";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options = {
          desc = "Cycle to previous buffer"; 
        };
      }
      {
        mode = "n";
        key = "<C-A-S-Right>";
        action = "<cmd>BufferLineMoveNext<cr>";
        options = {
          desc = "Move tab to the right";
        };
      }
      {
        mode = "n";
        key = "<C-A-S-Left>";
        action = "<cmd>BufferLineMovePrev<cr>";
        options = {
          desc = "Move tab to the left";
        };
      }
      {
        mode = "n";
        key = "<C-A-Right>";
        action = "<cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Cycle to next buffer";
        };
      }
      {
        mode = "n";
        key = "<C-A-Left>";
        action = "<cmd>BufferLineCyclePrev<cr>";
        options = {
          desc = "Cycle to previous buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>x";
        action = "<cmd>bdelete<cr><cmd>BufferLineCycleNext<cr>";
        options = {
          desc = "Delete current puffer and then cycle to next buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>cp";
        action = "<cmd>Copilot toggle<cr>";
        options = {
          desc = "Toggle copilot completions";
        };
      }
      {
        mode = "n";
        key = "<leader>ct";
        action = "<cmd>Neotree toggle<cr><cmd>CopilotChatToggle<cr><cmd>Neotree toggle<cr>";
        options = {
          desc = "Toggle Copilot Chat Window";
        };
      }
      {
        mode = "i";
        key = "<Tab>";
        action = "copilot#Accept('<Tab>')";
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-e>";
        options = {
          expr = true;
          silent = true;
        };
      }
    ];
  };
}
