function love.load()
    images = {}
    images["sheep"] = love.graphics.newImage("sheep.png")
    images["bg"] = love.graphics.newImage("background.png")
    all_sheep = {}
    love.graphics.setBackgroundColor(1,1,1)
end

function love.update(dt)
    if love.mouse.isDown(2) then os.exit() end
end

function love.draw()
    local sheep = images["sheep"]
    local ox = 100
    local oy = 100
    local sw = sheep:getWidth()
    local sh = sheep:getHeight()
    local mx = love.mouse:getX()
    local my = love.mouse:getY()

    local scaleX = (mx-ox)/sw
    local scaleY = (my-oy)/sh

    local wx = love.graphics.getWidth()
    local wy = love.graphics.getHeight()
    local bx = images.bg:getWidth()
    local by = images.bg:getHeight()

    love.graphics.draw(images.bg, 0, 0, 0, wx/bx, wy/by)

    if love.mouse.isDown(1) then
        --print("Saving "..scaleX..","..scaleY)
        all_sheep[#all_sheep+1] = {x=scaleX, y=scaleY}
    end

    for _,v in ipairs(all_sheep) do
        love.graphics.draw(sheep, ox, oy, 0, v.x, v.y)
    end

    love.graphics.setColor(0.8, 0.8, 0.0)
    love.graphics.draw(sheep, ox, oy, 0, scaleX, scaleY)

    love.graphics.setColor(1, 1, 1)
end
