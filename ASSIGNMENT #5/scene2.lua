-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local sceneName = ...

local composer = require( "composer" )

local scene = composer.newScene( sceneName )

---------------------------------------------------------------------------------


local widget = require( "widget" )


local back
local score = 0 -- ****************


-- ***************************
local function finish_alien()
    if score > 1 then 
        composer.showOverlay( "game_over" )
        audio.pause( 1 )
    end 
end 


local function tap_back( event )
    composer.gotoScene( "home", {effect="slideLeft", time=400} )
end 




