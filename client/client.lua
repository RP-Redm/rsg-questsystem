local RSGCore = exports['rsg-core']:GetCoreObject()
local createdEntries = {}
CanTakeDailyMission = false 
CanTakeHourlyMission = false 

-- Quest NPC Prompts
CreateThread(function()
    for i = 1, #Config.QuestNPC do
        local questnpc = Config.QuestNPC[i]

        exports['rsg-core']:createPrompt(questnpc.prompt, questnpc.promptcoords, RSGCore.Shared.Keybinds['J'], questnpc.name,
        {
            type = 'client',
            event = 'rsg-questsystem:client:CheckMissionMenu',
            args = {questnpc.questtype},
        })

        createdEntries[#createdEntries + 1] = {type = "PROMPT", handle = questnpc.prompt}

        if questnpc.showblip then
            local QuestBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, questnpc.promptcoords)
            local blipSprite = questnpc.blipSprite

            SetBlipSprite(QuestBlip, questnpc.blipSprite, true)
            SetBlipScale(QuestBlip, questnpc.blipScale)
            Citizen.InvokeNative(0x9CB1A1623062F402, QuestBlip, questnpc.blipName)

            createdEntries[#createdEntries + 1] = {type = "BLIP", handle = QuestBlip}
        end
    end
end)

RegisterNetEvent('rsg-questsystem:client:CheckMissionMenu', function(questtype)
	if questtype == 'daily' then
		TriggerEvent('rsg-questsystem:client:DailyMissionMenu')
	end
	if questtype == 'hourly' then
		TriggerEvent('rsg-questsystem:client:HourlyMissionMenu')
	end
end)

RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    RSGCore.Functions.TriggerCallback('rsg-questsystem:server:CheckMission', function(data)
        CanTakeDailyMission = data
    end, "dailymission")
    RSGCore.Functions.TriggerCallback('rsg-questsystem:server:CheckMission', function(data)
        CanTakeHourlyMission = data
    end, "hourlymission")
end)

RegisterNetEvent("rsg-questsystem:client:TakeDailyMission", function()
    if RSGCore.Functions.GetPlayerData().metadata["dailymission"] == 0 or not RSGCore.Functions.GetPlayerData().metadata["dailymission"] then  
        RSGCore.Functions.TriggerCallback('rsg-questsystem:server:CheckMission', function(data)
            if data then 
                local Random_Mission = math.random(1, #Config.Daily_Mission)
                TriggerServerEvent("rsg-questsystem:server:TakeDailyMission", Random_Mission)
                TriggerEvent("rsg-questsystem:client:CheckProgress", "dailymission")
            end
        end, "dailymission")
    else 
        RSGCore.Functions.Notify("You have already received a quest, you can check the progress")
    end 
end)

RegisterNetEvent("rsg-questsystem:client:TakeHourlyMission", function()
    if RSGCore.Functions.GetPlayerData().metadata["hourlymission"] == 0 or not RSGCore.Functions.GetPlayerData().metadata["hourlymission"] then
        RSGCore.Functions.TriggerCallback('rsg-questsystem:server:CheckMission', function(data)
            if data then 
                local Random_Mission = math.random(1, #Config.Hourly_Mission)
                TriggerServerEvent("rsg-questsystem:server:TakeHourlyMission", Random_Mission)
                TriggerEvent("rsg-questsystem:client:CheckProgress", "hourlymission")
            end
        end, "hourlymission")
    else 
        RSGCore.Functions.Notify("You have already received a quest, you can check the progress")
    end 
end)

RegisterNetEvent("rsg-questsystem:client:CheckProgress", function(type)
    if type == "dailymission" then 
        if Config.Daily_Mission[RSGCore.Functions.GetPlayerData().metadata["dailymission"]] then 
            TriggerServerEvent("rsg-questsystem:server:CheckProgress", "dailymission", Config.Daily_Mission[RSGCore.Functions.GetPlayerData().metadata["dailymission"]].required, Config.Daily_Mission[RSGCore.Functions.GetPlayerData().metadata["dailymission"]].reward_item, Config.Daily_Mission[RSGCore.Functions.GetPlayerData().metadata["dailymission"]].reward_money)
        end 
    else 
        if Config.Hourly_Mission[RSGCore.Functions.GetPlayerData().metadata["hourlymission"]] then 
            TriggerServerEvent("rsg-questsystem:server:CheckProgress", "hourlymission", Config.Hourly_Mission[RSGCore.Functions.GetPlayerData().metadata["hourlymission"]].required, Config.Hourly_Mission[RSGCore.Functions.GetPlayerData().metadata["hourlymission"]].reward_item, Config.Hourly_Mission[RSGCore.Functions.GetPlayerData().metadata["hourlymission"]].reward_money)
        end 
    end 
end)
