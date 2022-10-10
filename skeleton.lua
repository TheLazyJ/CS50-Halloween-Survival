-- Share basemonster and Object from Classic

Skeleton = Basemonster:extend()

-- Generate a new skeleton
function Skeleton:new(x, y)
    Skeleton.super.new(self, x, y)
    self.speed = 50
    self.life = 10
    self.image = love.graphics.newImage("img/monster/skeleton.png")
    self.width, self.heigth = self.image:getDimensions() 
    self.value = 150 --number of points monster give
end

-- Draw Skeleton
function Skeleton:draw()
    love.graphics.draw(self.image, self.x, self.y)
end