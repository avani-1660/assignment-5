-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
---background
local background = display.newImageRect( "assets/bkg-clouds.png", 570, 570 )
background.x = display.contentCenterX
background.y = display.contentCenterY
background.id = "background" 

--ground
local theGround = display.newImageRect( "assets/land.png", 350, 150 )
theGround.x = display.contentCenterX
theGround.y = display.contentHeight
theGround.id = "the ground"

local physics = require( "physics" )
physics.start()

halfW = display.contentWidth*0.5
halfH = display.contentHeight*0.5


-- Score
score = 0
scoreText = display.newText(score, halfW, 10)

-- Called when the balloon is tapped by the player
-- Increase score by 1
local function balloonTouched(event)
    if ( event.phase == "began" ) then
        Runtime:removeEventListener( "enterFrame", event.self )
        event.target:removeSelf()
        score = score + 1
        scoreText.text = score
    end
end

-- Called when the bomb is tapped by the player
-- Half the score as a penalty
local function bombTouched(event)
    if ( event.phase == "began" ) then
        Runtime:removeEventListener( "enterFrame", event.self )
        event.target:removeSelf()
        score = math.floor(score * 0.5)
        scoreText.text = score
    end
end

-- Delete objects which has fallen off the bottom of the screen
local function offscreen(self, event)
    if(self.y == nil) then
        return
    end
    if(self.y > display.contentHeight + 50) then
        Runtime:removeEventListener( "enterFrame", self )
        self:removeSelf()
    end
end

-- Add a new falling balloon or bomb
local function addNewBalloonOrBomb()
    -- You can find red_ballon.png and bomb.png in the GitHub repo
    local startX = math.random(display.contentWidth*0.1,display.contentWidth*0.9)
    if(math.random(1,5)==1) then
        -- BOMB!
        local bomb = display.newImageRect( "assets/bomb.png", 50, -150)
        bomb.x = display.contentCenterX
        bomb.y = display.contentCenterY-210

        physics.addBody( bomb )
        bomb.enterFrame = offscreen
        Runtime:addEventListener( "enterFrame", bomb )
        bomb:addEventListener( "touch", bombTouched )
    else
        -- Balloon
        local balloon = display.newImageRect( "assets/red_balloon.png", 75, -150)
        balloon.x = display.contentCenterX
        balloon.y = display.contentCenterY-210
        physics.addBody ( balloon )
        balloon.enterFrame = offscreen
        Runtime:addEventListener( "enterFrame", balloon )
        balloon:addEventListener( "touch", balloonTouched )
    end
end



-- Add a new balloon or bomb now
addNewBalloonOrBomb()

-- Keep adding a new balloon or bomb every 0.5 seconds
timer.performWithDelay( 1000, addNewBalloonOrBomb, 0 )

