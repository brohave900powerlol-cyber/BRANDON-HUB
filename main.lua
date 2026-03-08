-- BRANDON HUB: PREMIUM AUTO-JOINER
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local TS = game:GetService("TweenService")

-- Cleanup
if game:GetService("CoreGui"):FindFirstChild("BrandonFancy") then 
    game:GetService("CoreGui").BrandonFancy:Destroy() 
end

-- 1. FANCY UI DESIGN
local Screen = Instance.new("ScreenGui", game:GetService("CoreGui"))
Screen.Name = "BrandonFancy"

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 220, 0, 90)
Main.Position = UDim2.new(0.5, -110, 0.1, 0) -- Top Center
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel = 0

-- Styling
local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 15)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0, 170, 255)
Stroke.Thickness = 2
Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Fancy Gradient
local Grad = Instance.new("UIGradient", Main)
Grad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 50, 150))
})

-- Text Labels
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "BRANDON HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1

local Status = Instance.new("TextLabel", Main)
Status.Size = UDim2.new(1, 0, 0, 30)
Status.Position = UDim2.new(0, 0, 0, 45)
Status.Text = "🔍 Scanning Servers..."
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.BackgroundTransparency = 1

-- 2. PULSING GLOW ANIMATION
task.spawn(function()
    while task.wait(1) do
        local tween = TS:Create(Stroke, TweenInfo.new(1), {Thickness = 4})
        tween:Play()
        task.wait(1)
        local tween2 = TS:Create(Stroke, TweenInfo.new(1), {Thickness = 2})
        tween2:Play()
    end
end)

-- 3. SMART AUTO-JOIN LOGIC
local function updateStatus(txt)
    Status.Text = txt
end

task.spawn(function()
    task.wait(8) -- Let the brainrots load
    
    -- Check for Rare Brainrots (Strawberry Elephant, etc.)
    local foundRare = false
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name:find("Strawberry") or obj.Name:find("Elephant") or obj.Name:find("Secret") then
            foundRare = true
            break
        end
    end

    if foundRare then
        updateStatus("✅ RARE FOUND! Staying.")
        Stroke.Color = Color3.fromRGB(0, 255, 100) -- Turn Green
    else
        updateStatus("❌ No Rares. Hopping...")
        task.wait(2)
        -- Put your server hop logic here or use the one we made earlier
        local TeleportService = game:GetService("TeleportService")
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    end
end)
