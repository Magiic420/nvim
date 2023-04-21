local function getKey(table, searchValue)
    for key, value in pairs(table) do
        if value == searchValue then
            return key
        end
    end

    return nil
end

local bufr = vim.api.nvim_win_get_buf(0)

local current_file = vim.fn.expand(vim.api.nvim_buf_get_name(bufr)) -- File name of the cuurent buffer

local current_file_without_ext = string.gsub(current_file, '%.[^.]*$', '')

-- Here is the list of languages to their respective file extensions  
local languages = {
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

-- The command to run the file, 
-- Using string.format is easiest and looks the best
local compilers = {
    ["Rust"] = string.format("rustc %s -o %s && %s", current_file, current_file_without_ext, current_file_without_ext),
    ["Python"] = string.format("python3 -u %s", current_file),
    ["C"] = string.format("gcc %s -o %s && %s", current_file, current_file_without_ext, current_file_without_ext),
    ["Cpp"] = string.format("g++ %s -o %s && %s", current_file, current_file_without_ext, current_file_without_ext),
    ["C_sharp"] = "dotnet run",
    ["Java"] = string.format("javac %s && java %s", current_file, current_file),
    ["Star"] = string.format("star %s", current_file),
    ["V"] = string.format("v run %s", current_file),
    ["Lua"] = string.format("lua %s", current_file)
}

local function run()
    -- Saves the fil before running
    vim.cmd(':w')
    
    -- Gets the file extension
    local file_ext = string.match(current_file, '%.[^.]*$')

    -- Gets the language from the languages table using a reverse look up by value
    -- To get the language
    local language = getKey(languages, file_ext)
    
    -- This makes the command that runs eg. 'javac App.java && java App.java'
    -- local command = ""..compilers[language] .. '\n'
    local command = current_file

    -- This makes a new buffer at the bottom of the screen
    vim.cmd('botright split new')
    vim.cmd('enew')
    vim.cmd('buffer #')
    
    -- Sets the buffer to terminal mode
    local term_id = vim.fn.termopen('bash')
    local bufnr = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
    
    --

    -- vim.api.nvim_chan_send(term_id, 'clear\n')

    vim.api.nvim_chan_send(term_id, command)
end

vim.api.nvim_create_user_command("Test",
    function()
        local _buffer = vim.api.nvim_win_get_buf(0)
        local _fileName = vim.fn.expand(vim.api.nvim_buf_get_name(_buffer))
        print(_fileName)
        
        local _fileNameWithoutExt = string.gsub(_fileName, '%.[^.]*$', '')
        print(_fileNameWithoutExt)
        
        local _ext = string.match(_fileName, '%.[^.]*$')

        print(_ext)

        print(getKey(languages,_ext))
    end,
    {})

vim.api.nvim_create_user_command("RunOld",
    function()
        run()
    end,
    {} )
