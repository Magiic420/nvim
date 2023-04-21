local function terminal()
    vim.cmd('botright split new')
    vim.cmd('enew')
    vim.cmd('buffer #')

    vim.fn.termopen('bash')
    -- local bufnr = vim.api.nvim_get_current_buf()

    -- vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
end

vim.api.nvim_create_user_command("NewTerminal",
    function()
        terminal()
    end,
    {})
