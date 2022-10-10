-- Base monster to be use with differents Bullets

-- Extend library Object that is provided in Classic
Basebullet = Object:extend()

function Basebullet:checkBulletCollision(obj, dmg, j, value)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + 50

    if  self_right > obj_left
    and self_left < obj_right
    and self_bottom > obj_top
    and self_top < obj_bottom then

    	--Return true to confirm bullet hit target
    	self.hit = true

    	-- Remove life, if under baseline, remove monster from listOfMonsters
        obj.life = obj.life - dmg
        if obj.life <= 0 then
            -- Add scores, remove monster, play monster death sound
        	playerscore = playerscore + value
        	table.remove(listOfMonsters, j)
            love.audio.stop(sfxmonsterdeath)
            sfxmonsterdeath:play()
        end
    end
end