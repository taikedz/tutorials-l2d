function love.load()
end

function love.update(dt)
end

function love.draw()
    if not myfont then
        myfont = love.graphics.getFont()
    end
    if not segments then
        segments = 0
        step = 1
    else
        if segments > 19 or segments < 1 then
            step = -step
        end
    end

    segments = segments + step
    segTXT = love.graphics.newText(myfont, segments)

    love.graphics.rectangle("line", 100, 100, 150, 170, 40, 40, segments) -- It seems segments only start being refined at 8 ; below that, segment count remains the same
    love.graphics.draw(segTXT, 170, 180)

    love.timer.sleep(0.5)
end
