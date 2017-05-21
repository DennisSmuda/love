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

  main_canvas = love.graphics.newCanvas(320, 240)
  main_canvas:setFilter('nearest', 'nearest')

  love.window.setMode(960, 720)
  love.graphics.setLineStyle('rough')
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
  love.graphics.setCanvas(main_canvas)
  love.graphics.clear()

  for _, game_object in ipairs(game_objects) do
    game_object:draw()
  end

  love.graphics.setCanvas()
  love.graphics.draw(main_canvas, 0, 0, 0, 3, 3)
end


-- Mouse Press
function love.mousepressed(x, y, button)
  if button == 1 then
    game_object.dead = true
  end
end


-- Create Game Object
function createGameObject(type, x, y, opts)
  local game_object = _G[type](type, x, y, opts)
  table.insert(game_objects, game_object)
  return game_object
end

