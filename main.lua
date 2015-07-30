local fps = 60
local animCounter = 0
local animPlayer = 0
local facingDirection = "right"
local jumpTrigger = false
local jumpFrame = 0

uM = 1 / fps
uC = 0

function love.load()

	setScreen = love.window.setMode(640,480, {vsync=true, fsaa=4})
	plyr_r_1 = love.graphics.newImage("gfx/player/1_r.png")
	plyr_id = love.graphics.newImage("gfx/player/2_r.png")
	plyr_r_3 = love.graphics.newImage("gfx/player/3_r.png")
	tgrass = love.graphics.newImage("gfx/grass.png")
	bg = love.graphics.newImage("gfx/clouds.png")
	player_x = 64
	player_y = 64
	player_vs = 0

end

function love.update(dt)

	if dt > uM then
	
		dt = uM 

	end

	uC = uC + dt

	while uC >= uM do

		local jump = love.keyboard.isDown("z") -- AZERTY and QWERTY support
		local left = love.keyboard.isDown("q") -- Same here
		local right = love.keyboard.isDown("d") -- Nothing to add here

		if right then

			player_x = player_x + 2
			animPlayer = 1
			facingDirection = "right"
			if animCounter > 30 then	

				animCounter = 0

			else

				animCounter = animCounter + 1

			end

		elseif left then

			player_x = player_x - 2
			animPlayer = 1
			facingDirection = "left"
			if animCounter > 30 then	

				animCounter = 0

			else

				animCounter = animCounter + 1

			end

		elseif jump then

			if player_y == 330 then

				jumpTrigger = true

			end

		elseif love.keyboard.isDown("z","d") then

			player_x = player_x + 2
			animPlayer = 1
			facingDirection = "right"
			if animCounter > 30 then	

				animCounter = 0

			else

				animCounter = animCounter + 1

			end

			if player_y == 330 then

				jumpTrigger = true

			end

		elseif love.keyboard.isDown("z","q") then

			player_x = player_x - 2
			animPlayer = 1
			facingDirection = "left"
			if animCounter > 30 then	

				animCounter = 0

			else

				animCounter = animCounter + 1

			end

		end

		if jumpTrigger == true then

			if jumpFrame < 15 then

				if player_vs == 0 then

					player_vs = 4

				else

					player_vs = player_vs * 1.05

				end

				if player_vs > 8 then

					player_vs = 8

				end

				player_y = player_y - player_vs
				jumpFrame = jumpFrame + 1

			else

				jumpTrigger = false
				jumpFrame = 0
				player_vs = player_vs / 4

			end

		end

		function love.keyreleased(key)

			if key == "d" or key == "q" then

				animPlayer = 0
				animCounter = 0

			end

		end

		function love.draw()

			local dFps = love.timer.getFPS()
            if dFps > 60 then
            
                dFps = 60
            
            end

			love.graphics.print("FPS:" .. tostring(dFps) .. "; player_x: " .. tostring(player_x) .. "; player_y: " .. tostring(player_y) .. "; jumpTrigger: " .. tostring(jumpTrigger),32,32)
			love.graphics.setBackgroundColor(0,191,255)
			love.graphics.draw(bg,0,0)
			love.graphics.draw(tgrass,0,0)
			if animCounter == 0 or (animCounter > 10 and animCounter < 20) then

				love.graphics.draw(plyr_id,player_x,player_y)

			elseif animCounter < 10 then

				love.graphics.draw(plyr_r_1,player_x,player_y)

			else

				love.graphics.draw(plyr_r_3,player_x,player_y)

			end

		end

		if player_y >= 330 then

			if jumpTrigger == false then

				player_y = 330
				player_vs = 0

			end

		else

			if jumpTrigger == false then

				if player_vs == 0 then

					player_vs = 1

				elseif player_vs > 0 and player_vs < 8 then

					player_vs = player_vs * (1.05)

				else

					player_vs = 8

				end

				player_y = player_y + player_vs

			end

		end

		uC = uC - uM

	end

end