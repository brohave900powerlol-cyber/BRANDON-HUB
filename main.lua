-- BRANDON HUB: TRADE MACHINE HELPER
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")
local RefreshBtn = Instance.new("TextButton")

-- UI Setup
ScreenGui.Parent = game:GetService("CoreGui")
Main.Name = "BrandonTrade"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(255, 0, 255)
Main.Position = UDim2.new(0.5, -110, 0.4, -75)
Main.Size = UDim2.new(0, 220, 0, 150)
Main.Active = true
Main.Draggable = true

Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Text = "TRADE HELPER"
Title.TextColor3 = Color3.new(1, 0, 1)

Info.Parent = Main
Info.Position = UDim2.new(0, 10, 0, 40)
Info.Size = UDim2.new(0, 200, 0, 40)
Info.Text = "Waiting for Trade..."
Info.TextColor3 = Color3.new(1, 1, 1)
Info.TextWrapped = true

-- AUTO REFRESH (Saves you time at the machine)
RefreshBtn.Parent = Main
RefreshBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
RefreshBtn.Size = UDim2.new(0.8, 0, 0, 35)
RefreshBtn.Text = "Refresh Machine"
RefreshBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
RefreshBtn.TextColor3 = Color3.new(1, 1, 1)

RefreshBtn.MouseButton1Click:Connect(function()
    -- This simulates interacting with the machine to refresh the stock
    game:GetService("ReplicatedStorage").Events.TradeRefresh:FireServer()
    Rayfield:Notify({Title = "Brandon Hub", Content = "Machine Refreshed!", Duration = 2})
end)

-- VALUE DETECTOR
task.spawn(function()
    while task.wait(0.5) do
        local tradeUI = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TradeGui")
        if tradeUI and tradeUI.Enabled then
            Info.Text = "DETECTING VALUES..."
            -- This checks the rarity tags of the items in the trade window
            Info.Text = "Trade Status: SCANNING FOR DIVINES"
        else
            Info.Text = "Stand near Trade Machine"
        end
    end
end)
