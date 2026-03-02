-- BRANDON-HUB: GUI Edition
local Library = {} -- You can use a library, but here is a custom simple one
local Players = game:GetService("Players")
local lp = Players.LocalPlayer

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrandonHubUI"
ScreenGui.Parent = lp:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false -- Keeps GUI active after you die

-- Main Frame (The Menu)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 250)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true -- Simple dragging
MainFrame.Parent = ScreenGui

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "BRANDON HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Parent = MainFrame

-- BUTTON CREATOR FUNCTION
local function CreateButton(name, pos, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = pos
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Parent = MainFrame
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- 1. SPEED BUTTON
CreateButton("Set Speed (50)", UDim2.new(0.05, 0, 0, 40), function()
    lp.Character.Humanoid.WalkSpeed = 50
end)

-- 2. INSTA-GRAB BUTTON
CreateButton("Insta-Grab", UDim2.new(0.05, 0, 0, 90), function()
    game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
        fireproximityprompt(p)
    end)
end)

-- 3. NO LAG (FPS BOOST) BUTTON
CreateButton("No Lag (FPS)", UDim2.new(0.05, 0, 0, 140), function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.Plastic
            v.Reflectance = 0
        end
    end
end)

-- 4. CLOSE BUTTON
CreateButton("Close Menu", UDim2.new(0.05, 0, 0, 190), function()
    ScreenGui:Destroy()
end)
