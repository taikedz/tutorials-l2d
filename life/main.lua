life = {}
life.redraw = true
require "loop" -- The custom loop that is aware of life.redraw

function love.load()
    love.graphics.setBackgroundColor(1, 1, 1)

    cellSize = 5
    
    gridXCount = 140
    gridYCount = 100

    life.grid = {}
    for y = 1, gridYCount do
        life.grid[y] = {}
        for x = 1, gridXCount do
            life.grid[y][x] = false
        end
    end

    love.keyboard.setKeyRepeat(true)

    counter = 0
end

function love.update(dt)
    m_floor = math.floor
    lm_isDown = love.mouse.isDown

    mouseX = love.mouse.getX()
    mouseY = love.mouse.getY()

    selectedX = m_floor(mouseX / cellSize) + 1
    selectedY = m_floor(mouseY / cellSize) + 1

    local left_click = lm_isDown(1)
    local right_click = lm_isDown(2)
    
    if left_click or right_click then
        life.redraw = true
    end

    if left_click
      and selectedX <= gridXCount
      and selectedY <= gridYCount then
        life.grid[selectedY][selectedX] = true

    elseif right_click then
        life.grid[selectedY][selectedX] = false
    end

    -- Grid re-draw limiter
    counter = counter + dt
    if counter > 0.2 then
        counter = 0
        life.redraw = true
        life.nextGrid()
    end
end

function love.draw()
    local lg_setColor = love.graphics.setColor
    local lg_rectangle = love.graphics.rectangle

    local green_base = 100
    local green_top = 150
    local green_step = 5
    if not life.green_counter then
        life.green_counter = green_base
    else
        if not variant then variant = green_step
        elseif life.green_counter > green_top
            or life.green_counter < green_base
            then variant = -variant
        end
        life.green_counter = (life.green_counter + variant)
    end

    for y = 1, gridYCount do
        for x = 1, gridXCount do
            local cellDrawSize = cellSize - 1
            grid_y = life.grid[y]

            if x == selectedX and y == selectedY then
                lg_setColor(0, 1, 1)

            elseif grid_y[x] then -- alive
                local clr = {r=0.2, g=0.7, b=0.5}
                clr.r = x/gridXCount
                clr.g = life.green_counter / 256
                clr.b = y/gridYCount

                lg_setColor(clr.r, clr.g, clr.b)

            else -- dead
                lg_setColor(.86, .86, .86)
            end

            if false then -- turn off rectangle drawing for benchmarking
            lg_rectangle(
                'fill',
                (x - 1) * cellSize,
                (y - 1) * cellSize,
                cellDrawSize,
                cellDrawSize
            )
            end
        end
    end
end

function life.nextGrid()
    local nextGrid = {}
    for y = 1, gridYCount do
        nextGrid[y] = {}
        for x = 1, gridXCount do
            local neighbors = 0

            for dy = -1, 1 do
                for dx = -1, 1 do
                    if not (dy == 0 and dx == 0)
                    and life.grid[y + dy]
                    and life.grid[y + dy][x + dx] then
                        neighbors = neighbors + 1
                    end
                end
            end

            nextGrid[y][x] = neighbors == 3 or (life.grid[y][x] and neighbors == 2)
        end
    end

    life.grid = nextGrid
end
