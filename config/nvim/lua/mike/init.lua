local function init()
    require 'mike.vim'.init()
    require 'mike.theme'.init()
    require 'mike.languages'.init()
    require 'mike.chatgpt'.init()
    require 'mike.telescope'.init()
    require 'mike.terminal'.init()
    require 'mike.metals'.init()
    require 'mike.git'.init()
end

return {
    init = init,
}
