-- Check collision between monster and player

function checkCollision(a,b)
    local a_left = a.x - 17
    local a_right = a.x + 17
    local a_top = a.y - 25
    local a_bottom = a.y + 25

    local b_left = b.x - 17
    local b_right = b.x + 17
    local b_top = b.y - 25
    local b_bottom = b.y + 25

    if  a_right > b_left
    and a_left < b_right
    and a_bottom > b_top
    and a_top < b_bottom then
        --There is collision!
        return true
    else
        --If one of these statements is false, return false.
        return false
     end
end

function recordScore()
    -- Write new high score in file when Game Over
    if playerscore > tonumber(highscore) then
        love.filesystem.write("scores.txt", playerscore)
    end
end

--Back ground music
function backgroundmusic()
    song = love.audio.newSource("sounds/background.wav", "stream")
    song:setLooping(true)
    song:play()
end

-- Configure Sounds effects
function soundEffects()
    sfxennemyhit = love.audio.newSource("sounds/ennemyhit.wav", "static")

    sfxgun = love.audio.newSource("sounds/gun.mp3", "static")
    sfxgun:setVolume(0.5)

    -- Game Over sound, and boolean to play it once
    sfxgameover = love.audio.newSource("sounds/gameover.wav", "static")
    sfxgameOverplayed = false

    sfxzombie = love.audio.newSource("sounds/zombie.wav", "static")

    sfxskeleton = love.audio.newSource("sounds/skeleton.ogg", "static")

    sfxmonsterdeath = love.audio.newSource("sounds/monsterdeath.wav", "static")
end

-- Regroup everything link to gameover
function gameOver()
           -- Stop all sound and play gameOver SFX
           while sfxgameOverplayed == false do
                love.audio.stop()
                sfxgameover:play()
                sfxgameOverplayed = true
            end

           -- Clear all graphic and print lost screen
           love.graphics.clear()
           love.graphics.setColor(1, 0, 0 , 1)
           love.graphics.print("GAME OVER", 110, 220, 0, 8)
           love.graphics.setColor(1, 1, 1, 1)
           love.graphics.print("SCORE: " .. playerscore, 240, 400, 0, 4)

           -- Indicate if highscore was beaten
           if playerscore > tonumber(highscore) then
                love.graphics.setColor(1, 1, 0, 1)
                love.graphics.print("New High Score!", 205, 100, 0, 4)
           end

           love.graphics.setColor(1, 1, 1, 1)
           love.graphics.print("Press 'Enter' for new Game", 70, 500, 0, 4)

end