-- 1. THE MINI TOGGLE (JUST THE BUTTON)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local SpeedBtn = Instance.new("TextButton", ScreenGui)
local Corner = Instance.new("UICorner", SpeedBtn)

SpeedBtn.Name = "BrandonSpeed"
SpeedBtn.Size = UDim2.new(0, 40, 0, 40) -- Very small size
SpeedBtn.Position = UDim2.new(0, 15, 0.5, 0)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255) -- Purple (OFF)
SpeedBtn.Text = "S" -- 'S' for Speed
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.TextSize = 20
SpeedBtn.Draggable = true
SpeedBtn.Active = true
Corner.CornerRadius = UDim.new(1, 0) -- Makes it a circle

-- 2. THE SPEED LOGIC
getgenv().SpeedOn = false
local Multiplier = 1.5 -- Set this to how fast you want to go

SpeedBtn.MouseButton1Click:Connect(function()
    getgenv().SpeedOn = not getgenv().SpeedOn
    -- Changes color so you know if it's working
    SpeedBtn.BackgroundColor3 = getgenv().SpeedOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(150, 0, 255)
    SpeedBtn.Text = getgenv().SpeedOn and "ON" or "S"
end)

task.spawn(function()
    while task.wait() do
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") and getgenv().SpeedOn then
            local hum = char.Humanoid
            if hum.MoveDirection.Magnitude > 0 then
                char:TranslateBy(hum.MoveDirection * Multiplier)
            end
        end
    end
end)
