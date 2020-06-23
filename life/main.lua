life = {}
life.redraw = true
require "loop" -- The custom loop that is aware of life.redraw

function love.load()
    love.graphics.setBackgroundColor(1, 1, 1)

    cellSize = 5
    
    gridXCount = 400
    gridYCount = 300

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
    selectedX = math.floor(love.mouse.getX() / cellSize) + 1
    selectedY = math.floor(love.mouse.getY() / cellSize) + 1

    local left_click = love.mouse.isDown(1)
    local right_click = love.mouse.isDown(2)
    
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
    for y = 1, gridYCount do
        for x = 1, gridXCount do
            local cellDrawSize = cellSize - 1

            if x == selectedX and y == selectedY then
                love.graphics.setColor(0, 1, 1)
            elseif life.grid[y][x] then
                love.graphics.setColor(0.2, 0.7, 0.5)
            else
                love.graphics.setColor(.86, .86, .86)
            end

            love.graphics.rectangle(
                'fill',
                (x - 1) * cellSize,
                (y - 1) * cellSize,
                cellDrawSize,
                cellDrawSize
            )
        end
    end
    love.timer.sleep(0.01)
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
