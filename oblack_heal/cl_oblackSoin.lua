ESX = nil
PMenu = {}
PMenu.Data = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local obkDoc = { 
	Base = {  Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Docteur",  Blocked = true },
	Data = { currentMenu = "Docteur", "" },
	Events = {
		onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
			PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			local slide = btn.slidenum
			local btn = btn.name
			local data = {}
			local currentMenu, ped = menuData.currentMenu, GetPlayerPed(-1)
			local playerPed = GetPlayerPed(-1)
			if btn == "~g~Achetez ~w~des petit Soin" then
				TriggerServerEvent('oblackDc:pSoin')
                SetEntityHealth(playerPed, 150)
                ESX.ShowNotification('Vous avez ~g~achetez ~w~des petit Soins')
			elseif btn == "~g~Achetez ~w~des grand Soin" then
				TriggerServerEvent('oblackDc:gSoin')
                SetEntityHealth(playerPed, 200)
                ESX.ShowNotification('Vous avez ~g~achetez ~w~des grand Soins')
                elseif btn == "~r~fermer le menu" then
                    local text = '~o~Vous ~w~avez ~r~fini ~w~de parlez avec le ~g~Medecin' 
		            TriggerServerEvent('3dme:shareDisplay', text) 
					CloseMenu(true)
			end
		end,
	},
	Menu = {
		["Docteur"] = {
			b = {
				{name = "~g~Achetez ~w~des petit Soin", ask = "50$", askX = true},
                {name = "~g~Achetez ~w~des grand Soin", ask = "100$", askX = true},
				{name = "~r~fermer le menu", ask = ">", askX = true}
			}
		},
	}
}

local blips = {
	{title="Oblack Script Soin", colour=2, id=61, x = 343.609,y = -574.328,z = 43.28}
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.6)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
	end
end)

local obkDocPos = {
	{x = 343.609,y = -574.328,z = 43.28}
}

print("^1======================================================================^1")
print("^2[^4Script Docteur by^2] ^7: ^2 Oblack#0001^2")
print("^1======================================================================^1")

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(obkDocPos) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, obkDocPos[k].x, obkDocPos[k].y, obkDocPos[k].z)
            DrawMarker(29, v.x, v.y, 44.28, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 66, 238, 13,  155, false, true, 2, true, nil, nil, false)
            if dist <= 1.5 then
				ESX.ShowHelpNotification("Appuyez sur ~g~~INPUT_CONTEXT~~w~ pour parler au ~r~Docteur")
                if IsControlJustPressed(1,51) then
                    local text = '~o~Vous ~w~parlez avec le ~g~Medecin' 
		            TriggerServerEvent('3dme:shareDisplay', text) 
					CreateMenu(obkDoc)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    RequestModel(0xD47303AC)
    while not HasModelLoaded(0xD47303AC) do
    Wait(1)
end
        PED = CreatePed(1,0xD47303AC, 343.609, -574.328, 42.28, 154.109, false, true)
        SetBlockingOfNonTemporaryEvents(PED, true)
        SetPedDiesWhenInjured(PED, false)
        SetPedCanPlayAmbientAnims(PED, true)
        SetPedCanRagdollFromPlayerImpact(PED, false)
        SetEntityInvincible(PED, true)
        FreezeEntityPosition(PED, true)
end)

local oDoc = false
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if GetEntityHealth(GetPlayerPed(-1)) <= 159 then
            setoDoc()
            notify("~g~Vous \n~w~Vous êtes blessé penser à contacter un ~r~EMS ~w~ou allez a un ~g~hopital ~w~pour être soigné")
        elseif oDoc and GetEntityHealth(GetPlayerPed(-1)) > 160 then
            setNotoDoc()
        end
    end
end)

function setoDoc()
    oDoc = true
    RequestAnimSet("move_m@injured")
    SetPedMovementClipset(GetPlayerPed(-1), "move_m@injured", true)
end

function setNotoDoc()
    oDoc = false
    ResetPedMovementClipset(GetPlayerPed(-1))
    ResetPedWeaponMovementClipset(GetPlayerPed(-1))
    ResetPedStrafeClipset(GetPlayerPed(-1))
end

function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

---------------------------------
--- Copyright by OBlack#0001 ---
---------------------------------