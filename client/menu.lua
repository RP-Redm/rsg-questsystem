RegisterNetEvent("rsg-questsystem:client:DailyMissionMenu", function()
    local DailyMissionMenu = {
        {
            header = "📒 Daily Missions",
            isMenuHeader = true
        },
    }
     
    DailyMissionMenu[#DailyMissionMenu+1] = {
        header = "🗞 Get Daily Quests",
        txt = "Daily quests will reset when a new day passes",
        params = { 
            event = "rsg-questsystem:client:TakeDailyMission", 
        }
        
    }

    DailyMissionMenu[#DailyMissionMenu+1] = {
        header = '🛎 Checking process',
        txt = "Check your current task progress",
        params = { 
            event = "rsg-questsystem:client:CheckProgress",
            args = "dailymission", 
        }
        
    }
    
    DailyMissionMenu[#DailyMissionMenu+1] = {
        header = "⬅ Exit",
        txt = "",
        params = {
            event = "rsg-menu:client:closeMenu",
        }
    }
    exports['rsg-menu']:openMenu(DailyMissionMenu)
end)

RegisterNetEvent("rsg-questsystem:client:HourlyMissionMenu", function()
    local HourlyMissionMenu = {
        {
            header = "📘 Hourly Quests",
            isMenuHeader = true
        },
    }
     
    HourlyMissionMenu[#HourlyMissionMenu+1] = {
        header = "🗞 Get Hourly Quests",
        txt = "Daily quests will be reset every hour",
        params = { 
            event = "rsg-questsystem:client:TakeHourlyMission", 
        }
        
    }

    HourlyMissionMenu[#HourlyMissionMenu+1] = {
        header = '🛎 Checking process',
        txt = "Check your current task progress",
        params = { 
            event = "rsg-questsystem:client:CheckProgress",
            args = "hourlymission", 
        }
        
    }
    
    HourlyMissionMenu[#HourlyMissionMenu+1] = {
        header = "⬅ Exit",
        txt = "",
        params = {
            event = "rsg-menu:client:closeMenu",
        }
    }
    exports['rsg-menu']:openMenu(HourlyMissionMenu)
end)
