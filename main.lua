gamestart = 0 --decides whether the game is in the mustering phase or fight phase
goblin = 0 --number of goblins, increases with presses
musterTimer = 5 --timer before the fight
winTimer = 0 --timer that sets how long the pre-win/loss animation lasts
gobX = 1 --x position for goblin objects
gobY = 1 --y position for goblin objects
enemCount = 15 --how many enemies spawn at the level
level = 1 --which level the player is on
shimmy = 1 --shimmy position to simulate animation
prevShimmy = 0 --variable to help simulate shimmy
shimmyTimer = 0.3 --how long between the animation plays out
enemX= 1 --enemy position on X axis
enemY= 1 --enemy position on Y axis
music = love.audio.newSource("Kevin MacLeod - Master of the Feast.mp3", "stream") --music provided by Free Music Archive, composed by KevinMacLeod
sound = love.audio.newSource("INDN WAR DRUMS - Preguica-[6s Loop].mp3", "static") --muster screen music provided by Free Music Archive, composed by INDN WAR DRUMS
music:setVolume(0.3)

function love.load()
    --includes required files and initializes arrays of enemies and allies
    require "classic"
    Object = require "classic"
    require "gob"
    require "enemy"
    sound:play()
    gobList = {Gob:new(gobX,gobY)}
    enemList = {Enemy:new(enemX,enemY)}
    if gamestart == 1 then
        g = 1
        tempg = 1
        while g < goblin do
            sound:stop()
            if g % 10 == 0 then
            tempg = 1
            gobX = tempg
            gobY = gobY + 1
            table.insert(gobList, Gob(gobX, gobY))
            else
            gobX = tempg
            table.insert(gobList, Gob(gobX, gobY))
            end
            g = g + 1
            tempg = tempg + 1
        end
        e = 1
        tempe = 1
        while e < enemCount and e < 40 do
            if e % 10 == 0 then
            tempe = 1
            enemX = tempe
            enemY = enemY + 1
            table.insert(enemList, Enemy(enemX, enemY))
            else
            enemX = tempe
            table.insert(enemList, Enemy(enemX, enemY))
            end
            e = e + 1
            tempe = tempe + 1
        end
    end
    --prepares a background for display
    background = love.graphics.newImage("meadow.png")
end

function love.update(dt)
    --reduces the animation timer for goblins
    shimmyTimer = shimmyTimer - dt
    --counts down the timer before game starts
    if musterTimer > 0 then
        musterTimer = musterTimer - dt
    --switches from mustering screen to resolution screen
    elseif gamestart == 0 then
        gamestart = 1
        love.load(goblin)
        music:play()
    end

    --after resolution starts, display the fight between goblins and enemies for winTimer duration
    if gamestart == 1 and winTimer < 6 then
       winTimer = winTimer + dt
    end
end

function love.draw()
    love.graphics.setBackgroundColor(1,1,1)
    love.graphics.setColor(1,1,1)
    love.graphics.draw(background,0,0,0,3,3,300,300)

    if gamestart == 1 then
        
        --prints out all the goblins, their spears, and updates animation
        for i,gob in ipairs(gobList) do
            gob:draw(i,shimmy)
            love.graphics.line(330 + gob.x*10, 150+(20 * winTimer), 330 + (gob.x*10), 160 + (20 * winTimer))
            if shimmyTimer < 0 then
                setShimmy()
            end
        end
        
        --draws all enemies, changing their distance form goblins based on winTimer
        for i,enemy in ipairs(enemList) do
            enemy:draw(winTimer)
        end

        --display win or loss scenario once winTimer is up
        if winTimer >= 6 then
            if e < #gobList then
              levelChange()
            else
              love.graphics.print("You lost the game!", 300,20,0)
              love.graphics.print("Level reached: "..level,304,34,0)
              love.graphics.print("Press SPACE to restart",280,50,0)
              love.load()
            end
        end
    else
        gobi= love.graphics.newImage("muster_screen_gob.png")
        love.graphics.print("Muster the goblin tribes to fight for you!", 280, 55, 0, 1.3, 1.3)
        love.graphics.print("Press R to muster", 360, 75, 0, 1.3, 1.3)
        love.graphics.print("Level: "..level, 400, 30, 0, 1.3, 1.3)
        love.graphics.draw(gobi, 30, 100, 0, 1, 1)
    end
end

function love.keypressed(key, scancode, isrepeat)
    if key == "r" then
        goblin = goblin + 1
        print(goblin)
    elseif key == "space" and winTimer > 6 then
        --resets all the values of variables
        gamestart = 0
        level = 0
        goblins = {}
        enemCount = 15
        winTimer = 0
        musterTimer = 10
        goblin = 0
        gobY = 1
        enemX = 1
        enemY = 1
        love.load()
    end
end


function levelChange()
    level = level + 1
    gobList = {}
    enemCount = enemCount + 10
    gamestart = 0
    musterTimer = 10
    winTimer = 0
    goblin = 0
    gobY = 1
    enemX = 1
    enemY = 1
    sound:play()
    music:stop()
end

function setShimmy()
 
    if shimmy == 1 then
        shimmy = 0
        prevShim = 1
    elseif shimmy == -1 then
        shimmy = 0
        prevShim = -1
    elseif shimmy == 0 and prevShim == 1 then
        shimmy = -1
    else
        shimmy = 1
    end
    shimmyTimer = 2
end