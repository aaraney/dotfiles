require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = "|",
        section_separators = ""
    },
    tabline = {
        lualine_a = { 'buffers' }
    },
    sections = {
        lualine_c = {
            { 'filename', path = 1 }
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' }
    }
}
