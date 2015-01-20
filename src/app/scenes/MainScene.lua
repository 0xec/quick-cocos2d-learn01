local Player = require('src.app.roles.Player')
local Enemy1 = require('src.app.roles.Enemy1')
local Progress = require('src.app.ui.Progress')
local PauseLayer = require('src.app.ui.PauseLayer')

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
    -- 加载图片缓存
    display.addSpriteFrames('image/role.plist', 'image/role.png')
    display.addSpriteFrames('image/ui.plist', 'image/ui.png')
    -- 添加背景
    local bg = display.newSprite('image/background.png', display.cx, display.cy)
    self:addChild(bg)
    
    -- 创建角色
    player = Player.new(self)
    self:addChild(player)
    
    -- 创建第一个怪物
    enemy1 = Enemy1.new(self)
    self:addChild(enemy1)
    
    -- 创建操作层
    touch = display.newLayer()
    touch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == 'began' then
--            player:walk({x=event.x, y=event.y})
            index = index or 1  -- 取事件字符串的索引
            local fsmEvents = {"clickScreen", "clickEnemy", "beKilled", "stop"}
            player:doEvent(fsmEvents[index])
            index = index + 1
        end
    end)
    touch:setTouchEnabled(true)
    touch:setPosition(0, 0)
    touch:setContentSize(display.width, display.height)
    self:addChild(touch)
    
    -- 增加血条
    progress = Progress.new('#player-progress-bg.png', '#player-progress-fill.png')
    progress:setAnchorPoint(0, 1.0)
    progress:setPosition(display.left, display.top)
    self:addChild(progress)
    
    -- 暂停功能
    pauseLayer = PauseLayer.new(self)
    self:addChild(pauseLayer)
    
    -- 添加几个测试按钮
    self:addTestButton('测试走路', {x=100,y=100}, function() player:walk() end)
    self:addTestButton('测试攻击', {x=300,y=100}, function() player:attack() end)
    self:addTestButton('测试死亡', {x=600,y=100}, function() player:dead() end)
end

function MainScene:addTestButton(text, pos, callback)
    local PUSH_BUTTON_IMAGES = {
        normal = nil,
        pressed = nil,
        disabled = nil,
    }

    local btn = cc.ui.UIPushButton.new(PUSH_BUTTON_IMAGES, {scale9 = true})
    btn:setButtonSize(100, 100)
    btn:setPosition(pos.x, pos.y)
    --    btn:setButtonLabel('test')
    --    btn:setButtonLabel("normal", cc.ui.UILabel.new({
    --        text = "进入游戏",
    --        fontName = "宋体",
    --        size = 25
    --    }))
    btn:setButtonLabel('normal', cc.ui.UILabel.new({
        text = text,
        fontName = '黑体',
        size = 20
    }))
    btn:onButtonClicked(handler(self, callback))
    self:addChild(btn)
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
