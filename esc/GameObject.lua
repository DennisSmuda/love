local GameObject = Object:extend()

-- Game Object Constructor
--------------------
function GameObject:new(type, x, y, opts)
  self.type = type
  self.dead = false
  self.x, self.y = x, y
  self.previous_x, self.previous_y = x, y

  -- Assign options
  local opts = opts or {}
  for k,v in pairs(opts) do
    self[k] = v
  end

  -- Create a trail for gameobject upon creation
  timer:every(0.01, function()
    createGameObject('Trail', self.x, self.y, {
      xm = self.xm or 0,
      ym = self.ym or 0,
      angle = self.angle or 0,
      r = 25,
    })
  end)

end


-- Update Function
--------------------
function GameObject:update(dt)
  -- Position / Scaling
  local x, y = love.mouse.getPosition()
  self.x, self.y = x/3, y/3

  -- Angle / Velocity / Magnitude
  self.angle = math.atan2(self.y - self.previous_y, self.x - self.previous_x)
  self.vmag = Vector(self.x - self.previous_x, self.y - self.previous_y):len()


  self.xm = map(self.vmag, 0, 40, 1, 2)
  self.ym = map(self.vmag, 0, 40, 1, 0.25)

  self.previous_x, self.previous_y = self.x, self.y
end


-- Draw Function
--------------------
function GameObject:draw()
  pushRotate(self.x, self.y, self.angle)
  love.graphics.setColor(155, 255, 255)
  love.graphics.ellipse('fill', self.x, self.y, self.xm*15, self.ym*15)
  love.graphics.setColor(255, 255, 255)
  love.graphics.pop()
end


-- Return
-------------------
return GameObject
