function love.load()
    x = 100
    y = 150
    require("mousedata")

    print(print_places)
end

function love.update(dt)
    if love.keyboard.isDown("right") then
        x = x + 100 * dt
    end
    if love.keyboard.isDown("left") then
        x = x - 100 * dt
    end
    if love.keyboard.isDown("up") then
        y = y - 100 * dt
    end
    if love.keyboard.isDown("down") then
        y = y + 100 * dt
    end

    if love.mouse.isDown(1) then
        addmousedata()
    elseif love.mouse.isDown(2) then
        os.exit()
    end
end

function love.draw()
    printallmousedata()

    love.graphics.rectangle("line", x, y, 200, 150)
end
