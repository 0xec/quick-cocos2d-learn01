local PauseLayer = class('PauseLayer', function() 
    return display.newColorLayer(cc.c4b(162, 162, 162, 128))
end)

function PauseLayer:ctor()
    self:addUI()
    self:addTouch()
end

function PauseLayer:addUI()
    local background = display.newSprite('#pause-bg.png')
    background:setPosition(display.cx,display.cy)
    self:addChild(background)

    local backgroundSize = background:getContentSize()

    local home = cc.ui.UIPushButton.new(
        {normal = '#home-1.png', pressed = '#home-2.png', disabled = nil}
--        {scale9 = true}
    )
    home:setPosition(backgroundSize.width / 3, backgroundSize.height / 2)
    home:addTo(background)
    home:onButtonClicked(handler(self, self.home))
    
    
    local resume = cc.ui.UIPushButton.new(
        {normal = '#continue-1.png', pressed = '#continue-2.png', disabled=nil}
--        {scale9 = true}
    )
    resume:setPosition(backgroundSize.width * 2 / 3, backgroundSize.height / 2)
    resume:addTo(background)
    resume:onButtonClicked(handler(self, self.resume))
end

function PauseLayer:addTouch()
    local function onTouch(name, x, y)
        print("PauseLayer:addTouch")
    end

    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return onTouch(event.name, event.x, event.y)
    end)

    self:setTouchEnabled(true)
end

function PauseLayer:home()
    display.resume()
--    self:removeNodeEventListenersByEvent(cc.NODE_TOUCH_EVENT)
--    self:removeFromParentAndCleanup(true)
--    display.replaceScene(require("app.scenes.StartScene").new())
end

function PauseLayer:resume()
--    self:removeFromParentAndCleanup(true)
    display.resume()
end

return PauseLayer