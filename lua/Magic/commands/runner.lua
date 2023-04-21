local fileName, fileNameWithoutExt, fileExt, languages, compilers

local function getKey(table, searchValue)
    for key, value in pairs(table) do
        if value == searchValue then
            return key
        end
    end

    return nil
end

local function setup()
    local buffer =  vim.api.nvim_win_get_buf(0)

    fileName = vim.fn.expand(vim.api.nvim_buf_get_name(buffer))

    fileNameWithoutExt = string.gsub(fileName, '%.[^.]*$', '')

    fileExt = string.match(fileName, '%.[^.]*$')


    languages = {
        Rust = ".rs",
        Python = ".py",
        C = ".c",
        Cpp = ".cpp",
        C_sharp = ".cs",
        Java = ".java",
        Star = ".star",
        V = ".v",
        Lua = ".lua",
    }

    compilers = {
        ["Rust"] = string.format("rustc %s -o %s && %s", fileName, fileNameWithoutExt, fileNameWithoutExt),
        ["Python"] = string.format("python3 -u %s", fileName),
        ["C"] = string.format("gcc %s -o %s && %s", fileName, fileNameWithoutExt, fileNameWithoutExt),
        ["Cpp"] = string.format("g++ %s -o %s && %s", fileName, fileNameWithoutExt, fileNameWithoutExt),
        ["C_sharp"] = "dotnet run",
        ["Java"] = string.format("javac %s && java %s",fileName, fileName),
        ["Star"] = string.format("star %s", fileName),
        ["V"] = string.format("v run %s", fileName),
        ["Lua"] = string.format("lua %s", fileName)
    }
end

local function formCommand()
    local compiler = compilers[getKey(languages, fileExt)]
    local command = "" .. compiler .. "\n"

    return command
end

local function makeTerminal()
    vim.cmd('botright split new')
    vim.cmd('enew')
    vim.cmd('buffer #')

    local terminal = vim.fn.termopen('bash')
    local _buffer = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_option(_buffer, 'modifiable', true)

    return terminal
end

local function runner()
    setup()

    vim.cmd(':w')

    local terminal = makeTerminal()

    local command = formCommand()

    vim.api.nvim_chan_send(terminal, 'clear\n')
    vim.api.nvim_chan_send(terminal, command)
end

vim.api.nvim_create_user_command(
    "Run",
    function()
        runner()
    end,
    {})
