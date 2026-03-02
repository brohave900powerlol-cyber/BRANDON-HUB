local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "BRANDON HUB | 2026 EDITION",
   LoadingTitle = "Delta Executor Loading...",
   LoadingSubtitle = "by Brandon",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "BrandonHubConfigs",
      FileName = "MainConfig"
   }
})

local MainTab = Window:CreateTab("Main Cheats", 4483362458)
local Section = MainTab:CreateSection("Character Mods")

-- Variables for Logic
local lp = game.Players.LocalPlayer
local walkSpeedValue = 58
local jumpPowerValue = 50

-- SPEED MOD
MainTab:CreateSlider({
   Name = "WalkSpeed Custom",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 58,
   Flag = "WS_Slider",
   Callback = function(Value)
      walkSpeedValue = Value
   end,
})

MainTab:CreateToggle({
   Name = "Enable Speed [V]",
   CurrentValue = false,
   Flag = "WS_Toggle",
   Callback = function(Value)
      getgenv().LoopSpeed = Value
      task.spawn(function()
         while getgenv().LoopSpeed do
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
               lp.Character.Humanoid.WalkSpeed = walkSpeedValue
            end
            task.wait(0.1)
         end
         if lp.Character:FindFirstChild("Humanoid") then lp.Character.Humanoid.WalkSpeed = 16 end
      end)
   end,
})

-- JUMP MOD
MainTab:CreateSlider({
   Name = "Jump Power",
   Range = {50, 500},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JP_Slider",
   Callback = function(Value)
      jumpPowerValue = Value
   end,
})

MainTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfJump",
   Callback = function(Value)
      getgenv().InfJump = Value
      game:GetService("UserInputService").JumpRequest:Connect(function()
         if getgenv().InfJump then
            lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
         end
      end)
   end,
})

-- ANTI RAGDOLL
MainTab:CreateToggle({
   Name = "Anti Ragdoll",
   CurrentValue = false,
   Flag = "NoRagdoll",
   Callback = function(Value)
      if lp.Character and lp.Character:FindFirstChild("Humanoid") then
         lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, not Value)
         lp.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, not Value)
      end
   end,
})

Rayfield:Notify({
   Title = "Brandon Hub Active",
   Content = "Script loaded successfully on Delta!",
   Duration = 5,
   Image = 4483362458,
})
