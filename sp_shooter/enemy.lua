Enemy = Sprite:extend()

function Enemy:new(x, y, speed)
    Sprite.new(self, "snake.png", x, y, speed)
end

function Enemy:update(dt)
    self.x = self.x + (self.speed * dt)

    local east_limit = love.graphics.getWidth() - self.width

    if self.x < 0 then
        self.x = 0
        self.speed = -self.speed
    elseif self.x > east_limit then
        self.x = east_limit
        self.speed = -self.speed
    end
end
