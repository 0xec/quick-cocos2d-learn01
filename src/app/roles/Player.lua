local Player = class('Player', function()
    display.addSpriteFrames(string,string)
    return display.newSprite('')
end)

function Player:ctor()

end

return Player