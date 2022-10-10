--   Halloween Surival 
--       game 1.00
--   Made by TheLazy J

function love.load()
-- Load extra Lua file
    tick = require "libs/tick"
    Object = require "libs/classic"
    array = require "libs/array"
    require "extra"
    require "player"
    require "basemonster"
    require "zombie"
    require "skeleton"
    require "basebullet"
    require "bullet"
    require "maps"

-- Generate Player & Monster
    myPlayer = Player(100,100)
    listOfBullets = {}
    listOfMonsters = {}
    highscores = {}

    logo = love.graphics.newImage("img/logo.png")

-- Windows details
    love.window.setMode(800, 800, {x=5, y=35})

-- Game variables
    playerlife = 100
    playerscore = 0
    dmg = 1
    gameover = false
    cooldown = 0
    cooldown2 = 5
    spawnRate = 2.5
    spawnRate2 = 5
    gameOn = false
    randomCooldown = 2
    randomSpeed = 2

-- Make sure a score file exist in user/appdata/roaming
    if not love.filesystem.getInfo("scores.txt") then
        love.filesystem.newFile("scores.txt")
        love.filesystem.write("scores.txt", 1)
    end

-- Read highscore from file
    highscore = love.filesystem.read("scores.txt")

-- Play Background music
    backgroundmusic()

-- SFX sound effects
    soundEffects()

-- Load animation
    animation = playerAnimation()

-- Create all tile set quads and Maps
    mapstable = {} -- Table of maps
    table.insert(mapstable, Maps1()) -- Insert first map
    tileset() -- Attach img to main function
    tilesetquads() --Creates table about how tile set is splitted
end

function love.update(dt)
    -- Start of the Game On
    if gameOn == true and gameover == false then
    -- Random Spawn Generator 
       randomX = math.random(10,790)
       randomY = math.random(10,715)

    -- Update tick for dt, so that FPS do not change game speed
        tick.update(dt)

    -- Timer for game time and points
        timer0 = love.timer.getTime()

    -- Call on player and monster move
        myPlayer:update(dt)

    -- Move Monsters
        for i,v in ipairs(listOfMonsters) do
            v:moveToPlayer(myPlayer,dt)
            --v:moveRandom(dt)
        end

    -- Spawning Zombies with an accelerate rate up to 0.5
        cooldown = math.max(cooldown - dt,0)
        if cooldown == 0 then
            -- cooldown-time in seconds
            cooldown = spawnRate 
            
            -- Create Zombie
            sfxzombie:play()
            table.insert(listOfMonsters, Zombie(randomX, randomY))

            -- Change Spawn Rate
            if spawnRate > 0.4 then
                spawnRate = spawnRate - 0.1
            end
      end

    -- Spawning Skeleton 
        cooldown2 = math.max(cooldown2 - dt,0)
        if cooldown2 == 0 then
            -- cooldown-time in seconds
            cooldown2 = spawnRate2  

            -- Create Skeleton
            sfxskeleton:play()
            table.insert(listOfMonsters, Skeleton(randomX, randomY))

            -- Change Spawn Rate
            if spawnRate2 > 2 then
                spawnRate2 = spawnRate2  - 0.25
            end
      end

        
    -- Bullets interaction
        for i,v in ipairs(listOfBullets) do
            v:update(dt)

            -- Check Collisions with monsters and kill monster with <= 0 life
            for j, k in ipairs(listOfMonsters) do
                v:checkBulletCollision(listOfMonsters[j], dmg, j, listOfMonsters[j].value)
            end
     
            --If the bullet has the property hit 
            if v.hit then
                playerscore = playerscore + 1
                --Remove bullet from list
                table.remove(listOfBullets, i)
            end

        end

        -- Check collision between player and monsters, if true, remove life
        for i,v in ipairs(listOfMonsters) do
            if checkCollision(myPlayer, listOfMonsters[i]) == true then
                sfxennemyhit:play()
                playerlife = playerlife - 1
                if playerlife <= 0 then
                    gameover = true
                end
            end
        end

        -- Play player animation
        animation.currentTime = animation.currentTime + dt
        if animation.currentTime >= animation.duration then
            animation.currentTime = animation.currentTime - animation.duration
        end
    end
    -- End of the Game On

end


function love.draw()
    if gameOn == false then
        love.graphics.print("Welcome to Halloween Survival", 20, 100, 0, 4)
        love.graphics.print("To Start a game press 'N'", 95, 200, 0, 4)
        love.graphics.print("Current Highscore: " .. highscore, 110, 300, 0 ,4)
        love.graphics.draw(logo, 235, 400, 0, 0.35)

    else
        love.graphics.clear()

        -- Base Color
        love.graphics.setColor(1, 1, 1, 1)

        -- Draw Maps #1
        drawMaps(1)

        -- Print player
        myPlayer:draw()

        -- Print Monsters
        for i,v in ipairs(listOfMonsters) do
            v:draw()
        end

        -- Draw bullets
        for i,v in ipairs(listOfBullets) do
            v:draw()
        end

        -- Print score
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("LIFE: " .. playerlife, 570, 10 ,0,3 )
        love.graphics.print("SCORE: " .. playerscore, 10, 10 ,0,3 )
     
        if gameover == true then
            -- In extra.lua
            gameOver()
        end
    end
end


function love.keypressed(key)
    -- React to player input (move/shoot)
    myPlayer:keyPressed(key)

    -- Restart Game with 'Enter
    if love.keyboard.isDown('n') then
        gameOn = true
    end

    -- Restart Game with 'Enter
    if love.keyboard.isDown('return') then
        recordScore()
        love.event.quit("restart")
    end

    -- Quit game with 'Esc'
    if love.keyboard.isDown('escape') then
        recordScore()
        love.event.quit()
    end
end