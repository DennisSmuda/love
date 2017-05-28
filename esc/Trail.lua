local Trail = Object:extend()

-- Trail Constructor
----------------------
function Trail:new(type, x, y, opts)
  self.type = type
  self.dead = false
  self.x, self.y = x, y


  -- Assign options
  local opts = opts or {}
  for k,v in pairs(opts) do
    self[k] = v
  end

  -- Delete Trail after 15ms
  timer:tween(0.6, self, {r = 0}, 'linear', function () self.dead = true end)
end

-- Trail Update
----------------------
function Trail:update(dt)

end

-- Trail Draw
----------------------
function Trail:draw()
  pushRotate(self.x, self.y, self.angle)
  love.graphics.ellipse('fill', self.x, self.y, self.xm * (self.r + randomp(-2.5, 2.5)), self.ym * (self.r + randomp(-2.5, 2.5)))
  love.graphics.pop()
end

-- Return
return Trail
