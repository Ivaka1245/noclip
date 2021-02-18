local group
local states = {}

local noclip = false
local noclip_speed = 1.0
RegisterNetEvent('noclip:quick')
AddEventHandler('noclip:quick', function(t, target)
    if t == "noclip" then
		local msg = "disabled"
		if(noclip == false)then
		end

		noclip = not noclip

		if(noclip)then
			msg = "enabled"
		end

		TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
	end
end)

function getPosition()
  local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1),true))
  return x,y,z
end



function getCamDirection()
  local heading = GetGameplayCamRelativeHeading()+GetEntityHeading(GetPlayerPed(-1))
  local pitch = GetGameplayCamRelativePitch()

  local x = -math.sin(heading*math.pi/180.0)
  local y = math.cos(heading*math.pi/180.0)
  local z = math.sin(pitch*math.pi/180.0)

  -- normalize
  local len = math.sqrt(x*x+y*y+z*z)
  if len ~= 0 then
    x = x/len
    y = y/len
    z = z/len
  end

  return x,y,z
end

-- GetGameDirection(in lokale heading BLYAT)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if(noclip)then
		local ped = GetPlayerPed(-1)
        local x,y,z = getPosition()
        local dx,dy,dz = getCamDirection()
        local speed = noclip_speed
		SetEntityVisible(GetPlayerPed(-1), false, false)
		SetEntityInvincible(GetPlayerPed(-1), true)

      -- reset velocity
      SetEntityVelocity(ped, 0.0001, 0.0001, 0.0001)
      if IsControlPressed(0, 21) then
      	speed = speed + 3
      	end
      if IsControlPressed(0, 19) then
      	speed = speed - 0.5
      end
      -- forward
             if IsControlPressed(0,32) then -- MOVE UP
        	  x = x+speed*dx
        	  y = y+speed*dy
        	  z = z+speed*dz
      	     end

      -- backward
      	     if IsControlPressed(0,269) then -- MOVE DOWN
        	  x = x-speed*dx
        	  y = y-speed*dy
        	  z = z-speed*dz
      	     end
        SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
      	  else
      	  SetEntityVisible(GetPlayerPed(-1), true, false)
      	  SetEntityInvincible(GetPlayerPed(-1), false)

	     end
	end
end)

RegisterNetEvent("noclip:noclip")
AddEventHandler("noclip:noclip", function(t)
	local msg = "disabled"
	if(noclip == false)then
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)
