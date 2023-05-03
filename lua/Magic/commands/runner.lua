-- I don't write lua so please excuse the code
-- DISCLAIMER: even if a terminal is already open, this plugin will make another terminal
-- Get over it and rewrite this plugin yourself if you care that much 

-- Delcaring the 'global' variables at the top of the file
-- I don't know if this is conventional or not
local fileName, fileNameWithoutExt, fileExt, languages, compilers

-- Reverse lookup for a table
-- You input a value and it returns a key
-- Only useful if the key appears once else you're out of luck
-- Looks understandable
local function getKey(table, searchValue)
    for key, value in pairs(table) do
        if value == searchValue then
            return key
        end
    end

    return nil
end

-- Sets up everything
local function setup()
    -- Get the current buffe
    local buffer =  vim.api.nvim_win_get_buf(0)
    
    -- Grab the file name
    fileName = vim.fn.expand(vim.api.nvim_buf_get_name(buffer))
    
    -- Remove the extension
    fileNameWithoutExt = string.gsub(fileName, '%.[^.]*$', '')
    
    -- Save the extension for later use
    fileExt = string.match(fileName, '%.[^.]*$')

    -- List of file extensions
    languages = {
        Rust = ".rs",
        Python = ".py",
        C = ".c",
        Cpp = ".cpp",
        C_sharp = ".cs",
        Java = ".java",
        Star = ".star", -- My language I aam working on
        V = ".v",
        Lua = ".lua",
    }
    
    -- Here is where you can add or change what running this plugin with a specific language     
    compilers = {
        ["Rust"] = string.format("rustc %s -o %s && %s", fileName, fileNameWithoutExt, fileNameWithoutExt),
        ["Python"] = string.format("python3 -u %s", fileName),
        ["C"] = string.format("gcc %s -o %s && %s", fileName, fileNameWithoutExt, fileNameWithoutExt),
        ["Cpp"] = string.format("g++ %s -o %s && %s", fileName, fileNameWithoutExt, fileNameWithoutExt),
        ["C_sharp"] = "dotnet run",
        ["Java"] = string.format("javac %s && java %s",fileName, fileName),
        ["Star"] = string.format("star %s", fileName), -- My language
        ["V"] = string.format("v run %s", fileName),
        ["Lua"] = string.format("lua %s", fileName)
    }
end

-- Takes the information from the file extension and forms the command to run
local function formCommand()
    local compiler = compilers[getKey(languages, fileExt)]
    -- The '\n' is a return key
    local command = "" .. compiler .. "\n"

    return command
end

-- This function, which also appears in the terminal.lua file ( Another plugin I wrote that opens a terminal in vim ), makes a new terminal
-- I decided against siimply calling the :NewTerminal command ( Found in the terminal plugin ) so you can use this without needing to have that plugin installed too

local function makeTerminal()
    -- Make a new buffer at the bottom of the screen
    vim.cmd('botright split new')
    -- Open a new file
    vim.cmd('enew')
    -- Make the buffer a terminal
    vim.cmd('buffer #')
    
    -- Change this to change the shell
    local terminal = vim.fn.termopen('bash')
    
    -- get the buffer
    local _buffer = vim.api.nvim_get_current_buf()
    
    -- Make the buffer modifiable
    vim.api.nvim_buf_set_option(_buffer, 'modifiable', true)
    
    -- Return the temrinal object ( Reference? )
    return terminal
end

-- The main function of the file 
local function runner()
    setup()
    
    -- Auto save on run
    vim.cmd(':w')
    
    -- Makes the terminal
    local terminal = makeTerminal()
    
    -- Forms the command
    local command = formCommand()
    
    -- Clears the screen else two prompts appear, idk what happened there
    vim.api.nvim_chan_send(terminal, 'clear\n')
    
    -- Sends the command to the terminal
    vim.api.nvim_chan_send(terminal, command)
end

-- Makes the command
vim.api.nvim_create_user_command(
    "Run",
    function()
        runner()
    end,
    {})
