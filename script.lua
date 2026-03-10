-- BRADON HUB SERVER HOP 🐇
-- LIGHTWEIGHT DELTA EDITION
-- MADE BY BRANDON HUB

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- // KILL OLD VERSIONS // --
if CoreGui:FindFirstChild("BradonHop") then CoreGui.BradonHop:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "BradonHop"

-- // BOX SETUP // --
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 200, 0, 150)
Main.Position = UDim2.new(0.5, -100, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.Active = true
Main.Draggable = true -- Delta Built-in
Instance.new("UICorner", Main)

-- // TEXT // --
local T = Instance.new("TextLabel", Main)
T.Size = UDim2.new(1, 0, 0, 40)
T.Text = "BRADON HUB SERVER HOP 🐇"
T.TextColor3 = Color3.new(1, 1, 1)
T.Font = "GothamBold"
T.TextSize = 10
T.BackgroundTransparency = 1

-- // HOP BUTTON // --
local Hop = Instance.new("TextButton", Main)
Hop.Size = UDim2.new(0.9, 0, 0, 40)
Hop.Position = UDim2.new(0.05, 0, 0, 50)
Hop.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
Hop.Text = "START HOP"
Hop.TextColor3 = Color3.new(1, 1, 1)
Hop.Font = "GothamBold"
Instance.new("UICorner", Hop)

-- // DISCORD // --
local Disc = Instance.new("TextButton", Main)
Disc.Size = UDim2.new(0.9, 0, 0, 35)
Disc.Position = UDim2.new(0.05, 0, 0, 100)
Disc.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
Disc.Text = "COPY DISCORD"
Disc.TextColor3 = Color3.new(1, 1, 1)
Disc.Font = "GothamBold"
Instance.new("UICorner", Disc)

-- // SERVER HOP LOGIC // --
local function ServerHop()
    Hop.Text = "SEARCHING..."
    local PlaceID = game.PlaceId
    local CurrentJob = game.JobId
    
    local success, result = pcall(function()
        return game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100')
    end)
    
    if success then
        local Site = HttpService:JSONDecode(result)
        for _, v in pairs(Site.data) do
            if v.id ~= CurrentJob and v.playing < v.maxPlayers then
                Hop.Text = "TELEPORTING..."
                TeleportService:TeleportToPlaceInstance(PlaceID, v.id, Players.LocalPlayer)
                return
            end
        end
    end
    Hop.Text = "RETRYING..."
    task.wait(2)
    ServerHop()
end

Hop.MouseButton1Click:Connect(ServerHop)
Disc.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/xunwv9mwTJ")
    Disc.Text = "COPIED!"
    task.wait(2)
    Disc.Text = "COPY DISCORD"
end)