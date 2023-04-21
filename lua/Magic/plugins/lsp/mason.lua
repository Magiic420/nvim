local mason_status, mason = pcall(require, "mason")
if not mason_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    return
end

local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
    return
end


local installed_lsps = {
    "html",
    "cssls",
    "bashls",
    "clangd",
    "csharp_ls",
    "neomake",
    "dockerls",
    "jdtls",
    "pylsp",
    "vls",
    "rust_analyzer",
    "grammarly",
    "efm",
}

local formatters = {
    "prettier",
    "stylua",
    "eslint_d",
}

mason.setup()

mason_lspconfig.setup({
    ensured_installed = {
        installed_lsps,
    },
    
    automatic_installation = true,
})

mason_null_ls.setup({
    "prettier",
    "stylua",
    "eslint_d",
})

return installed_lsps
