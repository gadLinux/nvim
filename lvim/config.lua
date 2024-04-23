reload("user.options")

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "lua",
  "rust",
  "toml",
  "vimdoc"
}


-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })




-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "google-java-format",
    filetypes = { "java" },
    { command = "rustfmt", filetypes = { "rust" } },
  }
}
lvim.plugins = {
  { "vadimcn/codelldb" },
  { "mfussenegger/nvim-dap"},
  { "rcarriga/nvim-dap-ui"}, 
  {"nvim-treesitter/nvim-treesitter"},
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup()
    end,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-neotest/neotest-rust",
      "antoinemadec/FixCursorHold.nvim",
      "rouge8/neotest-rust",
    }
  }
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     inlay_hints = { enabled = true },
  --   },
  -- }
  -- {
  --   "mrcjkb/rustaceanvim",
  --   version = "^4",
  --   ft = { "rust" },
  -- --   config = function()
  -- --     vim.g.rustaceanvim = {
  -- --       server = {
  -- --         cmd = function()
  -- --           local mason_registry = require('mason-registry')
  -- --           local ra_binary = mason_registry.is_installed('rust-analyzer') 
  -- --           -- This may need to be tweaked, depending on the operating system.
  -- --           and mason_registry.get_package('rust-analyzer'):get_install_path() .. "/rust-analyzer"
  -- --           or "rust-analyzer"
  -- --           return { ra_binary } -- You can add args to the list, such as '--log-file'
  -- --         end,
  -- --       },
  -- --     }
  -- --   end,
  -- }
  
}


lvim.builtin.which_key.mappings["1"] = {
  "<cmd>lua vim.lsp.inlay_hint.enable(true)<CR>", "Enable hints"
}

require("neotest").setup({
  adapters = {
    -- require("neotest-python")({
    --   dap = { justMyCode = false },
    -- }),
    require("neotest-rust"),
    -- require("neotest-bash"),
    -- require("neotest-vim-test")({
    --   ignore_file_types = { "python", "vim", "lua" },
    -- }),
  },
})



lvim.builtin.which_key.mappings["t"] = {
  name = "Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.builtin.which_key.mappings["T"]= {
    name = "Tests",
    r = { "<cmd>lua require'neotest'.run.run()<cr>", "Run nearest test" },
    n = { "<cmd>lua require'neotest'.run.run({strategy = 'dap'})<cr>", "Debug nearest test" },
    a = { "<cmd>lua require'neotest'.run.run(vim.fn.expand('%'))<cr>", "Run all test" },
    s = { "<cmd>lua require'neotest'.run.stop()<cr>", "Stop nearest test" },
}


-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--   callback = function(args)
--     -- local client = vim.lsp.get_client_by_id(args.data.client_id)
--     -- if client.server_capabilities.inlayHintProvider then

--       -- vim.lsp.inlay_hint.enable(true)
--       vim.lsp.inlay_hint.enable(true)
--       -- vim.lsp.inlay_hint.enable(args.buf, true)
--     -- end
--     -- whatever other lsp config you want
--   end
-- })

lvim.builtin.which_key.mappings["S"]= {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistenc:lua vim.lsp.inlay_hint.enable(0, true)e').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.keys.normal_mode["|"] = ":vsplit<CR>"
lvim.keys.normal_mode["-"] = ":split<CR>"

lvim.keys.normal_mode["Q"] = "<cmd>wqall!<CR>"
-- https://davelage.com/posts/nvim-dap-getting-started/
-- lvim.keys.normal_mode["<F3>"] = "<cmd>lua vim.lsp.inlay_hint.enable(true)<CR>"


lvim.builtin.dap.active = true
local dap = require('dap')

lvim.keys.normal_mode["<F1>"] = "<cmd>lua require'dap'.terminate()<cr>"
lvim.keys.normal_mode["<F6>"] = "<cmd>lua require'dap'.toggle_breakpoint()<cr>"
lvim.keys.normal_mode["<F5>"] = "<cmd>lua require'dap'.continue()<cr>"
lvim.keys.normal_mode["<F8>"] = "<cmd>lua require'dap'.step_over()<cr>"
lvim.keys.normal_mode["<F9>"] = "<cmd>lua require'dap'.step_out()<cr>"
lvim.keys.normal_mode["<F7>"] = "<cmd>lua require'dap'.step_into()<cr>"
lvim.keys.normal_mode["<F11>"] = "<cmd>lua require'dap'.pause()<cr>"
lvim.keys.normal_mode["<F55>"] = "<cmd>lua require'dap'.down()<cr>"
lvim.keys.normal_mode["<F2>"] = "<cmd>lua require'dapui'.toggle()<cr>"

-- https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '/Users/gaguilar/.local/share/lvim/mason/packages/codelldb/codelldb',
    args = {"--port", "${port}"},
  }
}

dap.configurations.rust = {
  {
    name = "Rust debug",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
    end,
    cwd = '${workspaceFolder}',
    -- program = '/Users/gaguilar/git-rust/ms-with-kafka/target/debug/service',
    stopOnEntry = false,
  },
}
