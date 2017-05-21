local GameObject = Object:extend()

function GameObject:new(type, x, y, opts)
  self.type = type
  self.dead = false
  self.x, self.y = x, y

  -- Assign options
  local opts = opts or {}
  for k,v in pairs(opts) do
    self[k] = v
  end

  -- Create a trail for gameobject upon creation
  timer:every(0.01, function()
    createGameObject('Trail', self.x, self.y, {r = 25})
  end)

end

function GameObject:update(dt)
  timer:update(dt)

  local x, y = love.mouse.getPosition()
  self.x, self.y = x/3, y/3
end

function GameObject:draw()
  love.graphics.circle('fill', self.x, self.y, 25)
end

return GameObject
