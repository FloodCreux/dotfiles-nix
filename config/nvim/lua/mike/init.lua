local function init()
    require 'mike.vim'.init()
    require 'mike.lazy'.init()
    require 'mike.lazy'.install()
    require 'mike.cmp'.init()
    require 'mike.languages'.init()
end

return {
    init = init,
}
