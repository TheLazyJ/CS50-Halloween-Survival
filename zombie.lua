-- Share basemonster and Object from Classic

Zombie = Basemonster:extend()

-- Generate a new zombie
function Zombie:new(x, y)
    Zombie.super.new(self, x, y)
    self.speed = 75
    self.life = 2
    self.image = love.graphics.newImage("img/monster/zombie.png")
    self.width, self.heigth = self.image:getDimensions() 
    self.value = 50 --number of points monster give
end

-- Draw Zombie
function Zombie:draw()
    love.graphics.draw(self.image, self.x, self.y)
end