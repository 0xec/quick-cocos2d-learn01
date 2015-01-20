
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    local bg = display.newSprite('image/background.png', display.cx, display.cy)
    self:addChild(bg)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
