Player = Object:extend()

-- Create new player
function Player:new(x,y)
    self.x = x
    self.y = y
    self.image = love.graphics.newImage("img/player/player.png")
    self.speed = 250
    self.width, self.heigth = self.image:getDimensions() 
end

-- Generate playemovement
function Player:update(dt)
	-- Config keyboard WASD and arrows to move
    if love.keyboard.isDown('w') then
        self.y = self.y - self.speed * dt
    end

    if love.keyboard.isDown('s') then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown('a') then
        self.x = self.x - self.speed * dt
    end

    if love.keyboard.isDown('d') then
        self.x = self.x + self.speed * dt
    end

    -- Get dimensions of windows
    local window_width, window_heigth  = love.graphics.getDimensions()

    -- Limit players in the dimensions of the windows
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

-- Draw the animation of the basic player
function Player:draw()
    --love.graphics.draw(self.image, self.x, self.y)
    local spriteNum = math.floor(animation.currentTime / animation.duration * #animation.quads) + 1
    love.graphics.draw(animation.spriteSheet, animation.quads[spriteNum], self.x, self.y, 0, 1.4)
end


function Player:keyPressed(key)
    --Check witch direction to shoot bullet
    if love.keyboard.isDown('up') or love.keyboard.isDown('left')  or love.keyboard.isDown('down') or love.keyboard.isDown('right') then
        if love.keyboard.isDown('up') and love.keyboard.isDown('left') then
            table.insert(listOfBullets, BulletDUL(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('up') and love.keyboard.isDown('right') then
            table.insert(listOfBullets, BulletDUR(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('down') and love.keyboard.isDown('left') then
            table.insert(listOfBullets, BulletDDL(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('down') and love.keyboard.isDown('right') then
            table.insert(listOfBullets, BulletDDR(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('down') then
            table.insert(listOfBullets, BulletDown(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('up') then
            table.insert(listOfBullets, BulletUp(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('left') then
            table.insert(listOfBullets, BulletLeft(self.x, self.y, self.width, self.heigth))
        elseif love.keyboard.isDown('right') then
            table.insert(listOfBullets, BulletRight(self.x, self.y, self.width, self.heigth))
        end

        -- Create audio each time new bullet
        love.audio.stop(sfxgun)
        sfxgun:play()
    end
end

function playerAnimation()
    local animation = {}
    animation.spriteSheet = love.graphics.newImage("img/player/playerAnimationbasic.png")
    animation.quads = {};
    local awidth = 46
    local aheight = 46
    local aduration = 5

    -- 2x46 px Row, 5x46 px coloumn, get the 10 pictures in a {}
    for y = 0, 92 - 46, aheight do
        for x = 0, 230 - 46, awidth do
            table.insert(animation.quads, love.graphics.newQuad(x, y, awidth, aheight, 230 , 92))
        end
    end

    animation.duration = duration or 1
    animation.currentTime = 0

    return animation
end