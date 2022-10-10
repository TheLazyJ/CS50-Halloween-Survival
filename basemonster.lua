-- Base monster to be use with differents monster

-- Extend library Object that is provided in Classic
Basemonster = Object:extend()

-- Get dimensions of windows
local window_width = love.graphics.getWidth()

-- Location of the creation of the monster
function Basemonster:new(x, y)
    self.x = x
    self.y = y
end

-- Monster basic movement
function Basemonster:moveToPlayer(myPlayer, dt)
    if myPlayer.x < self.x then
        self.x = self.x - self.speed * dt
    else
        self.x = self.x + self.speed * dt
    end

    if myPlayer.y < self.y then
        self.y = self.y - self.speed * dt
    else
        self.y = self.y + self.speed * dt
    end
end


-- Move monster left right
function Basemonster:moveRandom(dt)
    local temp = math.random(1,4)
end

function Basemonster:limits()
    -- Limit Monster in the dimensions of the windows
    if self.x < 0 then
        self.x = 0
    elseif self.y < 0 then
        self.y = 0
    elseif self.x + self.width > window_width  then
        self.x = window_width - self.width
    elseif self.y + self.heigth + 75 > window_heigth then
        self.y = window_heigth - self.heigth - 75
    end
end