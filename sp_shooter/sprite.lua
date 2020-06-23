Sprite = Object:extend()

function Sprite:new(image_path, x, y, speed)
    self.image = love.graphics.newImage(image_path)

    self.x = x
    self.y = y
    self.speed = speed

    self.default_x = x
    self.default_y = y
    self.default_speed = speed

    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Sprite:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Sprite:reset()
    self.x = self.default_x
    self.y = self.default_y
    self.speed = self.default_speed
end

function Sprite:checkCollision(obj)
    s = Sprite.bounds(self)
    o = Sprite.bounds(obj)

    if s.r > o.l and
       s.l < o.r and
       s.b > o.t and
       s.t < o.b then
        return true
    end

    return false
end

function Sprite.bounds(obj)
    return {
        l = obj.x,
        r = obj.x + obj.width,
        t = obj.y,
        b = obj.y + obj.height
    }
end
