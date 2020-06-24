Player = Sprite:extend()

function Player:new(x, y, speed)
    Sprite.new(self, util.available_path({"panda.png"}), x, y, speed)
end

function Player:update(dt)
    if love.keyboard.isDown("left") then
        self.x = self.x - self.speed * dt

    elseif love.keyboard.isDown("right") then
        self.x = self.x +  self.speed * dt
    end

    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 0

    elseif self.x > window_width - self.width then
        self.x = window_width - self.width
    end
end

function Player:keyPressed(key)
    if key == "space" then
        Bullet(self.x, self.y) -- registers itself
    end
end
