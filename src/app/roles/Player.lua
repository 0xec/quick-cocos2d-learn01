-- 玩家角色类

local Player = class('Player', function()
    return display.newSprite('#player1-1-1.png')
end)

function Player:ctor()
    self:setPosition(display.left + self:getContentSize().width / 2, display.cy)
    
    self:addAnimation()
    self:addStateMachine()
end

function Player:addAnimation()
    local animationNames = {"walk", "attack", "dead", "hit", "skill"}
    local animationFrameNum = {4, 4, 4, 2, 4}
    for i = 1, #animationNames do
        local frames = display.newFrames('player1-'..i..'-%d.png', 1, animationFrameNum[i])
        local animation = nil
        if animationNames[i] == "attack" then
            animation = display.newAnimation(frames, 0.1)
        else
            animation = display.newAnimation(frames, 0.2)
        end
        animation:setRestoreOriginalFrame(true)
        display.setAnimationCache('player1-' .. animationNames[i], animation)
    end
end

function Player:addStateMachine()
    fsm = {}
    cc.GameObject.extend(fsm)
        :addComponent('components.behavior.StateMachine')
        :exportMethods()
    
    fsm:setupState({
        initial = 'idle',
        events = {
            {name='clickScreen', from={'idle', 'attack'}, to='walk'},
            {name='clickEnemy',  from={'idle', 'walk'},   to='attack'},
            {name='beKilled', from={'idle', 'walk', 'attack'}, to='dead'},
            {name='stop', from={'walk', 'attack'}, to='idle' }
        },
        callbacks = {
            onidle = function() printInfo('idle') end,
            onwalk = function() printInfo('walk') end,
            onattack = function() printInfo('attack') end,
            ondead = function() printInfo('dead') end
        },
    })
end

function Player:doEvent(event)
    fsm:doEvent(event)
end

function Player:walk(target, callback)

    local function moveStop()
        transition.stopTarget(self)
        if callback then callback() end
    end
    
    local pos = {x=self:getPositionX(),y=self:getPositionY()}
    local length = math.sqrt(math.pow(target.x - pos.x, 2) + math.pow(target.y - pos.y, 2))
    local speed = 5 * length / display.width
    local seq = transition.sequence({
        cc.MoveTo:create(speed, target),
        cc.CallFunc:create(moveStop)
    })
    self:runAction(seq)
    transition.playAnimationOnce(self, display.getAnimationCache('player1-walk'))
end

function Player:attack()
    transition.playAnimationOnce(self, display.getAnimationCache('player1-attack'))
end

function Player:dead()
    transition.playAnimationOnce(self, display.getAnimationCache('player1-dead'))
end



return Player