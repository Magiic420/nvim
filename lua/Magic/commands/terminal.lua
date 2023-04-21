local function terminal()
    vim.cmd('botright split new')
    vim.cmd('enew')
    vim.cmd('buffer #')

    vim.fn.termopen('bash')
end

vim.api.nvim_create_user_command("NewTerminal",
    function()
        terminal()
    end,
    {})
