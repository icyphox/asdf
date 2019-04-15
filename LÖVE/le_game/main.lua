function love.load()
	x, y, w, h = 20, 20, 60, 20
end

function love.update(dt)
	w = w + 1
	h = h + 1
end

function love.draw()
	love.graphics.print("hi fam", 400, 300)
	love.graphics.rectangle("fill", x, y, w, h)
end
