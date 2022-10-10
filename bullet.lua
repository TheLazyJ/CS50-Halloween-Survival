-- Share basebullet and Object from Classic
BulletDown = Basebullet:extend()
BulletUp = Basebullet:extend()
BulletLeft = Basebullet:extend()
BulletRight = Basebullet:extend()
BulletDUL = Basebullet:extend()
BulletDUR = Basebullet:extend()
BulletDDL = Basebullet:extend()
BulletDDR = Basebullet:extend()

-- Draw Bullet every direction + diagonal

-- Bullet Down
function BulletDown:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletdown.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    -- collision checking
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

-- Direction of the bullets
function BulletDown:update(dt)
    self.y = self.y + self.speed * dt
end

-- Draw bullets
function BulletDown:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


-- Bullet Up
function BulletUp:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletup.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletUp:update(dt)
    self.y = self.y - self.speed * dt
end

function BulletUp:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


-- Bullet Left
function BulletLeft:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletleft.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletLeft:update(dt)
    self.x = self.x - self.speed * dt
end

function BulletLeft:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


-- Bullet Right
function BulletRight:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletright.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletRight:update(dt)
    self.x = self.x + self.speed * dt
end

function BulletRight:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

-- Bullet Diagonal Up left
function BulletDUL:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletdiaupleft.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletDUL:update(dt)
    self.x = self.x - self.speed * dt
    self.y = self.y - self.speed * dt
end

function BulletDUL:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


-- Bullet Diagonal Up Right
function BulletDUR:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletdiaupright.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletDUR:update(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y - self.speed * dt
end

function BulletDUR:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


-- Bullet Diagonal Down Left
function BulletDDL:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletdiadownleft.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletDDL:update(dt)
    self.x = self.x - self.speed * dt
    self.y = self.y + self.speed * dt
end

function BulletDDL:draw()
    love.graphics.draw(self.image, self.x, self.y)
end


-- Bullet Diagonal Down Right
function BulletDDR:new(x, y, width, height)
    self.image = love.graphics.newImage("img/weapon/bulletdiadownright.png")
    self.x = x + width/2
    self.y = y + height/2
    self.speed = 700
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function BulletDDR:update(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + self.speed * dt
end

function BulletDDR:draw()
    love.graphics.draw(self.image, self.x, self.y)
end