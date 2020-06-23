local print_places = {}

function addmousedata()
    print_places[#print_places+1] = {x = love.mouse.getX(), y = love.mouse.getY()}
end

function printmousedata(tx, ty)
    for a,b in pairs(love.mouse) do
        love.graphics.print(a .. " - " .. tostring(b) , tx, ty )
        ty = ty + 14
    end
end

function printdot(tx, ty)
    love.graphics.print(".", tx, ty)
end

function printallmousedata()
    for i,pos in ipairs(print_places) do
        printdot(pos.x, pos.y)
    end
end

