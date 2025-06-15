vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    local lspconfig = require("lspconfig")

    -- Python LSP
    lspconfig.pyright.setup({})

    -- C/C++ LSP
    lspconfig.clangd.setup({})

    -- YAML LSP
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          schemas = {
            kubernetes = "/*.k8s.yaml",
          },
        },
      },
    })

    -- Terraform LSP
    lspconfig.terraformls.setup({})
  end,
})

