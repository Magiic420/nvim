local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
    return
end

-- Recommended settings from nvim-tree documneation
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#8f32a8]])

nvimtree.setup({
    renderer = {
        icons = {
           glyphs = {
                folder = {
                    arrow_closed = "", -- arrow when folder is closed
                arrow_open = "", -- arrow when folder is open
                },
            },
        },
    },
    
    -- Makes working with multiple windows better, or so I've been told
    actions = {
        open_file = {
            window_picker = {
                enable = false,
            },
        },
    },
    




})
