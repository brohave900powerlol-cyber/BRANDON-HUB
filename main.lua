-- BRANDON HUB CUSTOM (NO LIBRARY)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")

-- Setup GUI
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "BrandonHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true -- So you can move it on your screen

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "BRANDON HUB"
Title.TextColor3 = Color3.new(1, 0, 1) -- Pink
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

-- FUNCTIONS --

-- 1. Anti-Kick Speed (Spoofing)
local speedActive = false
SpeedBtn.Parent = MainFrame
SpeedBtn.Position = UDim2.new(0, 10, 0, 50)
SpeedBtn.Size = UDim2.new(0, 180, 0, 40)
SpeedBtn.Text = "Speed: OFF"
SpeedBtn.Callback = function() end -- Button logic below

SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedBtn.Text = speedActive and "Speed: ON (45)" or "Speed: OFF"
    
    task.spawn(function()
        local lp = game.Players.LocalPlayer
        while speedActive do
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                -- This method is harder to detect than just setting WalkSpeed
                lp.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame + (lp.Character.Humanoid.MoveDirection * 0.5)
            end
            task.wait(0.01)
        end
    end)
end)

-- 2. Infinite Jump (No Kick)
local infJump = false
JumpBtn.Parent = MainFrame
JumpBtn.Position = UDim2.new(0, 10, 0, 100)
JumpBtn.Size = UDim2.new(0, 180, 0, 40)
JumpBtn.Text = "Inf Jump: OFF"

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump then
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

JumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    JumpBtn.Text = infJump and "Inf Jump: ON" or "Inf Jump: OFF"
end)

-- 3. Simple Highlight ESP
ESPBtn.Parent = MainFrame
ESPBtn.Position = UDim2.new(0, 10, 0, 150)
ESPBtn.Size = UDim2.new(0, 180, 0, 40)
ESPBtn.Text = "Enable ESP"

ESPBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            local h = Instance.new("Highlight", v.Character)
            h.FillColor = Color3.new(1, 0, 0)
        end
    end
end)
