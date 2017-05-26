-- Libs
Object = require 'lib/classic'
Timer = require 'lib/timer'

-- Require Classes
GameObject = require 'GameObject'
Trail = require 'Trail'


-- Load Function
function love.load()
  timer = Timer()

  love.mouse.setVisible(false)

  game_objects = {}
  game_object = createGameObject('GameObject', 100, 100)

  -- Canvases
  main_canvas = love.graphics.newCanvas(320, 240)
  main_canvas:setFilter('nearest', 'nearest')
  game_object_canvas = love.graphics.newCanvas(320, 240)
  game_object_canvas:setFilter('nearest', 'nearest')
  trail_canvas = love.graphics.newCanvas(320, 240)
  trail_canvas:setFilter('nearest', 'nearest')

  love.window.setMode(960, 720)
  love.graphics.setLineStyle('rough')

  -- Details
  trail_lines_extra_draw = {}
  timer:every(0.1, function()
    for i = 0, 360, 2 do
      if love.math.random(1, 10) >= 2 then trail_lines_extra_draw[i] = false
      else trail_lines_extra_draw[i] = true end
    end
  end)
end


-- Update Function
function love.update(dt)
  timer:update(dt)

  -- Update Objects
  for i = #game_objects, 1, -1 do
    local game_object = game_objects[i]
    game_object:update(dt)
    -- Remove dead objects
    if game_object.dead then table.remove(game_objects, i) end
  end
end


-- Draw Function
function love.draw()
  -- Draw Trails to separate Canvas
  love.graphics.setCanvas(trail_canvas)
  love.graphics.clear()

  for _, game_object in ipairs(game_objects) do
    if game_object.type == 'Trail' then
      game_object:draw()
    end
  end

  love.graphics.setBlendMode('subtract')
  for i = 0, 360, 2 do
    love.graphics.line(i, 0, i, 240)
    if trail_lines_extra_draw[i] then
      love.graphics.line(i+1, 0, i+1, 240)
    end
  end
  love.graphics.setBlendMode('alpha')
  love.graphics.setCanvas()

  -- Draw Gameobjects to separate Canvas
  love.graphics.setCanvas(game_object_canvas)
  love.graphics.clear()

  for _, game_object in ipairs(game_objects) do
    if game_object.type == 'GameObject' then
      game_object:draw()
    end
  end
  love.graphics.setCanvas()

  love.graphics.setCanvas(main_canvas)
  love.graphics.clear()
  love.graphics.draw(trail_canvas, 0, 0)
  love.graphics.draw(game_object_canvas, 0, 0)
  love.graphics.setCanvas()

  love.graphics.draw(main_canvas, 0, 0, 0, 3, 3)
end


-- Mouse Press
function love.mousepressed(x, y, button)
  if button == 1 then
    -- game_object.dead = true
  end
end


-- Create Game Object
function createGameObject(type, x, y, opts)
  local game_object = _G[type](type, x, y, opts)
  table.insert(game_objects, game_object)
  return game_object
end

function randomp(min, max)
  return (min > max and (love.math.random() * (min -max) + max)) or
         (love.math.random()*(max - min) + min)
end
