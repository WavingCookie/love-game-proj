local fps = 60
uM = 1 / fps
uC = 0

function love.load()

	setScreen = love.window.setMode(640,480, {vsync=true, fsaa=4})
	plyr_sprite = love.graphics.newImage("gfx/player.png")
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

		function love.draw()

			local dFps = love.timer.getFPS()

			love.graphics.print("FPS:" .. tostring(dFps),32,32)
			love.graphics.setBackgroundColor(0,191,255)
			love.graphics.draw(bg,0,0)
			love.graphics.draw(plyr_sprite,player_x,player_y)

		end

		player_y = player_y + player_vs
		if player_y > 360 then

			player_y = 360
			player_vs = 0

		else

			if player_vs == 0 then

				player_vs = 1

			elseif player_vs > 0 and player_vs < 8 then

				player_vs = player_vs * (1.05)

			else

				player_vs = 8

			end

		end

		uC = uC - uM

	end

end