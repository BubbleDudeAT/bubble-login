-- Register Events Server
RegisterServerEvent('bubble_login:QuitServer') -- register event for use from client side
RegisterServerEvent('bubble_login:CheckServer')


-- Event click button leave server
AddEventHandler('bubble_login:QuitServer', function()

  local LeaveMessage = 'You have logged out successfully, see you next time !'

  DropPlayer( source, LeaveMessage ) -- will kick the current player
  CancelEvent() -- cancel all events
  
end)


-- Event click button leave server
AddEventHandler('bubble_login:CheckServer', function( username, password )	

    local result = MySQL.Sync.fetchAll("SELECT * FROM accounts WHERE username = @username AND BINARY password = @password", { ['@username'] = username, ['@password'] = password } )	-- get only matched login with password in table players	
    local Player = result[1]
		
    if Player == nil then -- If resultat exist

		TriggerClientEvent('bubble_login:ErrorMessageClientInChat', -1, ErrorMessage) -- go to client event
	
	else -- otherwise
		
		TriggerClientEvent('bubble_login:ValidMessageClientInChat', -1, ValidMessage) -- go to client event
	
	end	
  
end)