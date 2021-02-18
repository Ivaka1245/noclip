TriggerEvent('es:addGroupCommand', 'nc', "admin", function(source, args, user)
	TriggerClientEvent("noclip:noclip", source)
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insufficienct permissions!")
end, {help = "Enable or disable noclip"})

