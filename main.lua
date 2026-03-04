-- ADOPT ME TRADE UTILITY
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Clean up old button
if PlayerGui:FindFirstChild("TradeUtil") then PlayerGui.TradeUtil:Destroy() end

-- Create Tiny Toggle
local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "TradeUtil"
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton", ScreenGui)
local Corner = Instance.new("UICorner", ToggleBtn)

ToggleBtn.Size = UDim2.new(0, 40, 0, 40)
ToggleBtn.Position = UDim2.new(0, 15, 0.6, 0)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255) -- Blue
ToggleBtn.Text = "TRD"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Draggable = true
ToggleBtn.Active = true
Corner.CornerRadius = UDim.new(1, 0)

-- UTILITY LOGIC
getgenv().AntiAFK = true

-- Anti-AFK (Stops you from getting kicked while waiting for trades)
task.spawn(function()
    while getgenv().AntiAFK do
        task.wait(30)
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new(0,0))
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    -- This sends a message to your console telling you when someone trades you
    print("Trade Utility is Active. Waiting for incoming trades...")
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
    task.wait(0.5)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
end)
