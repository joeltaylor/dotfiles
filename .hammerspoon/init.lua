local module = {}

module.debugging = false -- whether to print status updates

local eventtap  = require "hs.eventtap"
local event     = eventtap.event
local inspect   = require "hs.inspect"
local watchable = require "hs.watchable"


local keyHandler = function(e)
    local watchFor = { h = "left", j = "down", k = "up", l = "right" }
    local actualKey = e:getCharacters(true)
    local replacement = watchFor[actualKey:lower()]
    if replacement then
        local isDown = e:getType() == event.types.keyDown
        local flags  = {}
        for k, v in pairs(e:getFlags()) do
            if v and k ~= "fn" then -- fn will be down because that's our "wrapper", so ignore it
                table.insert(flags, k)
            end
        end
        if module.debugging then print("viKeys: " .. replacement, inspect(flags), isDown) end
        local replacementEvent = event.newKeyEvent(flags, replacement, isDown)
        if isDown then
            -- allow for auto-repeat
            replacementEvent:setProperty(event.properties.keyboardEventAutorepeat, e:getProperty(event.properties.keyboardEventAutorepeat))
        end
        return true, { replacementEvent }
    else
        return false -- do nothing to the event, just pass it along
    end
end

local modifierHandler = function(e)
    local flags = e:getFlags()
    local onlyControlPressed = false
    for k, v in pairs(flags) do
        onlyControlPressed = v and k == "fn"
        if not onlyControlPressed then break end
    end
    -- you must tap and hold fn by itself to turn this on
    if onlyControlPressed and not module.keyListener then
        if module.debugging then print("viKeys: keyhandler on") end
        module.keyListener = eventtap.new({ event.types.keyDown, event.types.keyUp }, keyHandler):start()
    -- however, adding additional modifiers afterwards is ok... its only when fn isn't down that we switch back off
    elseif not flags.fn and module.keyListener then
        if module.debugging then print("viKeys: keyhandler off") end
        module.keyListener:stop()
        module.keyListener = nil
    end
    return false
end


module.watchables = watchable.new("viKeys", true)

module.modifierListener = eventtap.new({ event.types.flagsChanged }, modifierHandler)

module.start = function()
    module.watchables.enabled = true
    module.modifierListener:start()
end

module.stop = function()
    if module.keyListener then
        module.keyListener:stop()
        module.keyListener = nil
    end
    module.modifierListener:stop()
    module.watchables.enabled = false
end

module.toggle = function()
    if module.watchable.enabled then
        module.stop()
    else
        module.start()
    end
end

module.watchExternalToggle = watchable.watch("viKeys.enabled", function(w, p, k, o, n)
    if not o and n then
        module.start()
    elseif o and not n then
        module.stop()
    end
end)


--[[
ctrl_table = {
    sends_escape = true,
    last_mods = {}
}

control_key_timer = hs.timer.delayed.new(0.15, function()
    ctrl_table["send_escape"] = false
    -- log.i("timer fired")
    -- control_key_timer:stop()
end
)

last_mods = {}

control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["ctrl"] == new_mods["ctrl"] then
      return false
  end
  if not last_mods["ctrl"] then
    -- log.i("control pressed")
    last_mods = new_mods
    ctrl_table["send_escape"] = true
    -- log.i("starting timer")
    control_key_timer:start()
  else
    -- log.i("contrtol released")
    -- log.i(ctrl_table["send_escape"])
    if ctrl_table["send_escape"] then
      -- log.i("send escape key...")
      hs.eventtap.keyStroke({}, "ESCAPE")
    end
    last_mods = new_mods
    control_key_timer:stop()
  end
  return false
end

control_tap = hs.eventtap.new({12}, control_handler)

control_tap:start()
]]--

module.start() -- autostart




return module