local bubble_login = true -- true = enable mod or use false to disabled mod

-- Main function to open login panel
function EnableGuiLogin(StatusGui) -- string 'StatusGui' can be true or false    
    
	bubble_login = StatusGui -- use to disable everything from if true, look like : EnableGuiLogin(true)


	SetNuiFocus(StatusGui, StatusGui) -- Disable all the control and active the FiveM native cursor

	DisplayRadar(false) -- Remove mini map	
	
	-- send in javascript
    SendNUIMessage({
        type = "EnableGuiLogin",
        StatusJs = StatusGui
    })
end


-- CallBack from server event : Error login
AddEventHandler('bubble_login:ErrorMessageClientInChat', function( ErrorMessage )
	Noti("error", "", "YOUR PASSWORD OR USERNAME IS WRONG", 4000, "right")
end)
RegisterNetEvent('bubble_login:ErrorMessageClientInChat') -- register event for use from server side


-- CallBack from server event : SuccessFul login
AddEventHandler('bubble_login:ValidMessageClientInChat', function( ValidMessage )
	

	EnableGuiLogin(false) -- Disable	
	DisplayRadar(true) -- Display mini map
	TriggerEvent('qb-multicharacter:client:chooseChar')
		
end)
RegisterNetEvent('bubble_login:ValidMessageClientInChat') -- register event for use from server side


-- Call disconnect button
RegisterNUICallback('bubble_login:LeaveServer', function()
	TriggerServerEvent( 'bubble_login:QuitServer' )		
end)


-- Call login button
RegisterNUICallback('bubble_login:LoginServer', function(data)

	local username = data.username
	local password = data.password

	TriggerServerEvent( 'bubble_login:CheckServer', username, password ) -- sent to server the local string from data. json
	
end)


-- Call error login
RegisterNUICallback('bubble_login:LoginErrorServer', function()
	Noti("error", "", "YOU NEED TO ENTER SOMETHING", 4000, "right")
end)


-- Init Player
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(2500)
        if bubble_login then

			EnableGuiLogin(true) -- required to lunch Nui		

		end		
		
        Citizen.Wait(0)

    end
end)


-- 
function Noti(type, title, message, time, position)
	SendNUIMessage({
		action = 'notification',
		type = type,
        title = title,
        message = message,
        time = time,
		position = position -- left - appears on the left side of the screen, right - appears on the right side of the screen
	})
end

RegisterNetEvent('bubble_login:Noti')
AddEventHandler('bubble_login:Noti', function(type, title, message, time, position)
	Noti(type, title, message, time, position)
end)