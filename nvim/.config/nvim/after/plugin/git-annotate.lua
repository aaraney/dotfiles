local Job = require('plenary.job')

-- copy github permalink of current line to clipboard
vim.keymap.set({ "n", "v" }, "<leader>pl", function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line = cursor[1]
    local filename = vim.api.nvim_buf_get_name(0)
    local permalink = gh_line_permalink(filename, line)
    vim.fn.setreg("+", permalink)
    vim.print(permalink)
end)


---return git hash for current HEAD
---@param filename string absolute path to file
---@return string hash for line in file
function rev_parse_head(filename)
    local dirname = vim.fs.dirname(filename)
    local stdout = {}
    local stderr = {}
    local status_code = {}
    local job = Job:new({
        command = 'git',
        args = { 'rev-parse', 'HEAD' },
        cwd = dirname,
        on_exit = function(_, code)
            table.insert(status_code, code)
        end,
        on_stderr = function(_, data)
            table.insert(stderr, data)
        end,
        on_stdout = function(_, data)
            table.insert(stdout, data)
        end,
    })
    job:sync()

    assert(status_code[1] == 0,
        "\n\tstaus code: " .. status_code[1] .. "\n\t" .. "stderr: " .. "'" .. table.concat(stderr) .. "'")

    assert(#stdout == 1, stdout)
    return stdout[1]
end

---return get a file's path relative to the git repo root
---@param filepath string absolute path to file
---@return string path relative to git repo root
function relative_to_repo_root(filepath)
    local dirname = vim.fs.dirname(filepath)
    local stdout = {}
    local stderr = {}
    local status_code = {}

    Job:new({
        command = 'git',
        args = { "rev-parse", "--show-prefix" },
        cwd = dirname,
        on_exit = function(_, code)
            table.insert(status_code, code)
        end,
        on_stderr = function(_, data)
            table.insert(stderr, data)
        end,
        on_stdout = function(_, data)
            table.insert(stdout, data)
        end,
    }):sync()

    assert(status_code[1] == 0,
        "\n\tstaus code: " .. status_code[1] .. "\n\t" .. "stderr: " .. "'" .. table.concat(stderr) .. "'")

    assert(#stdout == 1, "expected only one stdout entry, got " .. #stdout)
    local filename = vim.fs.basename(filepath)
    return stdout[1] .. filename
end

---comment
---@param remote? string
---@param cwd string
---@return string
local function repo_gh_url(remote, cwd)
    local status_code = {}
    local stderr = {}
    local stdout = {}

    Job:new({
        command = 'git',
        args = { 'remote', 'get-url', '--push', remote },
        -- TODO: not sure what happens if this is not specified?
        cwd = cwd,
        on_exit = function(_, code)
            table.insert(status_code, code)
        end,
        on_stderr = function(_, data)
            table.insert(stderr, data)
        end,
        on_stdout = function(_, data)
            table.insert(stdout, data)
        end,
    }):sync()

    assert(status_code[1] == 0,
        "\n\tstaus code: " .. status_code[1] .. "\n\t" .. "stderr: " .. "'" .. table.concat(stderr) .. "'")

    assert(#stdout == 1, "expected only one stdout entry, got " .. #stdout)
    return as_github_url(stdout[1])
end


---comment
---@param url string git remote url. e.g. https://github.com/aaraney/windmolen.git
---@return string github url to remote
function as_github_url(url)
    -- https://github.com/aaraney/windmolen.git
    -- git@github.com:aaraney/dotfiles.git
    -- nil if not found
    local gh_marker = "github.com"
    local start = string.find(url, gh_marker, 1, true)
    assert(start ~= nil, "'" .. gh_marker .. "' " .. "not found in " .. "'" .. url .. "'")
    local dot_git = string.find(url, ".git", 1, true)
    assert(dot_git ~= nil, "'.git' " .. "not found in " .. "'" .. url .. "'")

    local gh_end = start + string.len(gh_marker) - 1
    return gh_marker .. "/" .. string.sub(url, gh_end + 2, dot_git - 1)
end

-- unit test if I ever publish this
-- local urls = { "https://github.com/aaraney/windmolen.git", "git@github.com:aaraney/dotfiles.git" }
-- local out = {}
-- for _, value in ipairs(urls) do
--     table.insert(out, as_github_url(value))
-- end


function gh_line_permalink(filepath, line_number)
    -- gh permalink structure:
    -- {repo}/blob/{hash}/{path}#L{number}
    assert(vim.fn.filereadable(filepath) == 1, "file does not exist: " .. "'" .. filepath .. "'")
    local hash = rev_parse_head(filepath)
    local cwd = vim.fs.dirname(filepath)
    local relative_filepath = relative_to_repo_root(filepath)
    local repo_url = repo_gh_url("upstream", cwd)
    return "https://" .. repo_url .. "/blob/" .. hash .. "/" .. relative_filepath .. "#L" .. line_number
end
