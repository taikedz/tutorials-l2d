Bullet = Sprite:extend()

local all_bullets = {}

NGlib = require "NameGenerator"
ng = NGlib:init()

function Bullet:new(x, y)
    Sprite.new(self, "bullet.png", x, y, 700)

    local name = tostring(math.random(1000,9999)) .. " " .. ng:generate()

    self.name = name
    all_bullets[name] = self

    return self
end

function Bullet:update(dt)
    self.y = self.y + self.speed * dt

    if self.y > love.graphics.getHeight() then
        self:remove("missed its mark!")
    end
end

function Bullet:remove(message)
    if not message then message = "removed" end

    all_bullets[self.name] = nil

    print(self.name .. " : "..message)
end

function Bullet:checkCollision(obj)
    if not Sprite.checkCollision(self,obj) then return end

    self:remove("hit !")

    if obj.speed < 0 then
        obj.speed = obj.speed - 50
    else
        obj.speed = obj.speed + 50
    end
end

-- ++++++

function Bullet.updateAll(dt)
    for name,bullet in pairs(all_bullets) do
        bullet:update(dt)
    end
end

function Bullet.drawAll()
    for name,bullet in pairs(all_bullets) do
        bullet:draw()
    end
end

function Bullet.checkAllCollisions(obj)
    for name,bullet in pairs(all_bullets) do
        bullet:checkCollision(obj)
    end
end
