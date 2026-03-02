local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRANDON HUB | Reborn",
   LoadingTitle = "Loading Script...",
   LoadingSubtitle = "by Brandon",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrandonHub", 
      FileName = "MainConfig"
   }
})

local MainTab = Window:CreateTab("Main Cheats", 4483362458) -- Tab icon

-- REPLICATING YOUR SCREENSHOT DESIGN:

MainTab:CreateToggle({
   Name = "Speed Boost [V]",
   CurrentValue = false,
   Flag = "SpeedToggle", 
   Callback = function(Value)
      -- Speed logic goes here
   end,
})

MainTab:CreateSlider({
   Name = "Speed Value",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Speed",
   CurrentValue = 58,
   Flag = "SpeedSlider",
   Callback = function(Value)
      -- Update speed value
   end,
})

MainTab:CreateToggle({
   Name = "Anti Ragdoll",
   CurrentValue = false,
   Flag = "AntiRagdoll",
   Callback = function(Value)
   end,
})

MainTab:CreateToggle({
   Name = "Helicopter",
   CurrentValue = false,
   Flag = "Heli",
   Callback = function(Value)
   end,
})

MainTab:CreateSlider({
   Name = "Steal Radius",
   Range = {0, 100},
   Increment = 1,
   Suffix = "Radius",
   CurrentValue = 49,
   Flag = "StealRadius",
   Callback = function(Value)
   end,
})

Rayfield:Notify({
   Title = "Success",
   Content = "UI Loaded Successfully",
   Duration = 5,
   Image = 4483362458,
})
