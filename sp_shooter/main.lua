function love.load()
    Object = require "classic"
    require "sprite"
    require "player"
    require "enemy"
    require "bullet"

    player = Player(300, 20, 500)
    enemy = Enemy(325, 450, 100)
end

function love.update(dt)
    player:update(dt)
    enemy:update(dt)
    Bullet.updateAll(dt)
    Bullet.checkAllCollisions(enemy)
end

function love.keypressed(key)
    if key == "return" then
        enemy:reset()
        player:reset()
        return
    end
    player:keyPressed(key)
end

function love.draw()
    player:draw()
    enemy:draw()
    Bullet.drawAll()
end
