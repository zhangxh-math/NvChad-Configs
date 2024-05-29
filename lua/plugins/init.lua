
return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "lervag/vimtex",
    lazy = false,
    config = function()
      vim.g.tex_flavor = 'latex'
      vim.g.vimtex_compiler_method = 'latexmk'
      vim.g.vim_syntax_enabled = 1
--    vim.g.vimtex_compiler_method = 'nvr'
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_complete_enabled = 1
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_activate = 1
      vim.g.vimtex_quickfix_mode = 0
    end,
  },
  {
    "SirVer/ultisnips",
    lazy = false,
    config = function()
      vim.g.UltiSnipsSnippetDirectories = {'ultisnips'}
      vim.g.UltiSnipsExpandTrigger = '<Tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<Tab>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<S-Tab>'
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
  -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",  -- 使用 BufReadPost 事件懒加载
    config = {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = {"latex"},
        },
        ensure_installed = {"c", "cpp", "lua", "python", "javascript", "typescript", "html", "css", "markdown", "latex"},
      }
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",  -- 使用 InsertEnter 事件懒加载
    dependencies = {
      {
        "windwp/nvim-autopairs",
        opts = {
          disable_filetype = { "TelescopePrompt", "vim", "tex" },
        },
      }
    },
    config = function()
      local cmp = require 'cmp'
      local lspkind = require('lspkind')
      cmp.setup {
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        mapping = cmp.mapping({
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Down>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<Up>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = 'vimtex', priority = 8 },
          { name = 'nvim_lsp', priority = 7 },
          { name = 'ultisnips', priority = 10 },
          { name = 'spell', priority = 9 },
          { name = 'path', priority = 6 },
        }),
        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              vimtex = "{TEX}",
              nvim_lsp = "[LSP]",
              ultisnips = "[Snip]",
              spell = "[Spell]",
              path = "[Path]",
            }
          }),
        },
      }
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "InsertEnter",  -- 使用 InsertEnter 事件懒加载
  },
  {
    "hrsh7th/cmp-path",
    event = "InsertEnter",  -- 使用 InsertEnter 事件懒加载
  },
  {
    "quangnguyen30192/cmp-nvim-ultisnips",
    event = "InsertEnter",  -- 使用 InsertEnter 事件懒加载
  },
  {
    "f3fora/cmp-spell",
    event = "InsertEnter",  -- 使用 InsertEnter 事件懒加载
  },
  {
    "onsails/lspkind-nvim",
    event = "InsertEnter",  -- 使用 InsertEnter 事件懒加载
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",  -- 使用 BufReadPre 事件懒加载
    config = function()
        local lspconfig = require('lspconfig')
        local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

        -- Function to setup diagnostics signs
        local function setup_diagnostics_signs(bufnr)
            for type, icon in pairs(signs) do
                local sign = "LspDiagnosticsSign" .. type
                vim.fn.sign_define(sign, { text = icon, texthl = sign, numhl = "" })
            end
            vim.diagnostic.open_float({ focusable = true, border = "single" })
        end

        -- Configure LSP servers for LaTeX, Lua, and Python
        local servers = { "texlab", "lua_ls", "pyright" }
        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup {
                on_attach = function(client, bufnr)
                    setup_diagnostics_signs(bufnr)
                end
            }
        end
    end
  },
  -- 加载 impatient.nvim 进行模块缓存
  {
    'lewis6991/impatient.nvim',
    config = function()
      require('impatient')
    end
  }
}
