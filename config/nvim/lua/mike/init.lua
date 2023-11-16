local function init()
    require 'mike.vim'.init()
    require 'mike.dashboard'.init()
    require 'mike.which-key'.init()
    require 'mike.theme'.init()
    require 'mike.languages'.init()
    require 'mike.chatgpt'.init()
    require 'mike.telescope'.init()
    require 'mike.terminal'.init()
    require 'mike.metals'.init()
    require 'mike.git'.init()
    require 'mike.noice'.init()
    require 'mike.cmp'.init()
    require 'mike.conform'.init()
end

return {
    init = init,
}
