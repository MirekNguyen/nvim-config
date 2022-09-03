local status, lsp_installer = pcall(require, 'nvim-lsp-installer')
if (not status) then return end

lsp_installer.setup({
  ensure_installed = { "clangd", "bashls", "cssls", "emmet_ls", "html", "intelephense", "jsonls", "sumneko_lua",
    "tailwindcss", "tsserver" },
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})
