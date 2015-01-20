-- 怪物1
local Progress = require('src.app.ui.Progress')

local Enemy1 = class('Enemy', function()
    return display.newSprite('#enemy1-1-1.png')
end)

function Enemy1:ctor()
    self:setPosition(display.right - self:getContentSize().width / 2, display.cy)
    
    progress = Progress.new("#small-enemy-progress-bg.png", "#small-enemy-progress-fill.png")
    local size = self:getContentSize()
    progress:setPosition(size.width * 2 / 3 - 10, size.height + progress:getContentSize().height / 2)
    self:addChild(progress)
end

return Enemy1