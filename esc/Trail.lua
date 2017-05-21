local Trail = Object:extend()

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
  timer:after(0.15, function() self.dead = true end)
end

function Trail:update(dt)

end

function Trail:draw()
  love.graphics.circle('fill', self.x, self.y, self.r)
end

return Trail
