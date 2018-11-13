local Particle = class("Particle")

function Particle:initialize(x, y)
    self.pos = Vector(x, y)
    self.velocity = Vector(math.random() / 2 - 0.25, math.random() / 2 - 0.25)
    if math.random() > 0.5 then
        self.color = {99 / 255, 199 / 255, 77 / 255}
    else
        self.color = {247 / 255, 118 / 255, 34 / 255}
    end
    self.lifetime = 50
    self.dead = false
end

function Particle:update()
    self.pos.x = self.pos.x + self.velocity.x
    self.pos.y = self.pos.y + self.velocity.y
    self.lifetime = self.lifetime - 1
    
    self.dead = self.lifetime < 0
end

function Particle:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", math.round(self.pos.x), math.round(self.pos.y), 1, 1)
    love.graphics.setColor(1,1,1,1)
end

local Particles = class("Particles")

function Particles:initialize(x, y)
    self.id = Entities:addEntity(self)

    self.pos = Vector(x, y)

    self.particles = {Particle(self.pos.x, self.pos.y)}

    self.emissionTimer = 3
end

function Particles:update()
    for _, particle in pairs(self.particles) do
        if not particle.dead then
            particle:update()
        end
    end

    self.emissionTimer = self.emissionTimer - 1
    if self.emissionTimer == 0 then
        table.insert(self.particles, Particle(self.pos.x, self.pos.y))

        self.emissionTimer = 3
    end
end

function Particles:draw()
    for _, particle in pairs(self.particles) do
        if not particle.dead then
            particle:draw()
        end
    end
end

return Particles
