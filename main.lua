-- BRANDON HUB: THE COMPLETE EDITION
local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local lp = Players.LocalPlayer

local speedEnabled = false
local grabEnabled = false
local currentSpeed = 50

-- 1. GUI CONTAINER
local BrandonHub = Instance.new("ScreenGui")
BrandonHub.Name = "BrandonHub"
BrandonHub.Parent = game:GetService("CoreGui")
BrandonHub.ResetOnSpawn = false

-- 2. THE TOGGLE CIRCLE (Open/Close Button)
local ToggleCircle = Instance.new("TextButton")
ToggleCircle.Name = "ToggleCircle"
ToggleCircle.Parent = BrandonHub
ToggleCircle.Size = UDim2.new(0, 50, 0, 50)
ToggleCircle.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleCircle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleCircle.Text = "B"
ToggleCircle.TextColor3 = Color3.fromRGB(135, 206, 235)
ToggleCircle.TextSize = 24
ToggleCircle.Font = Enum.Font.GothamBold
ToggleCircle.Active = true
ToggleCircle.Draggable = true -- You can move the circle too!

local CircleCorner = Instance.new("UICorner", ToggleCircle)
CircleCorner.CornerRadius = UDim.new(1, 0) -- Makes it a perfect circle

local CircleStroke = Instance.new("UIStroke", ToggleCircle)
CircleStroke.Color = Color3.fromRGB(135, 206, 235)
CircleStroke.Thickness = 2

-- 3. THE MAIN HUB FRAME
local Main = Instance.new("Frame")
Main.Name = "MainFrame"
Main.Visible = false -- Hidden by default
Main.Size = UDim2.new(0, 350, 0, 500)
Main.Position = UDim2.new(0.5, -175, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Main.Parent = BrandonHub

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = Color3.fromRGB(135, 206, 235)
MainStroke.Thickness = 2

-- LOGO & TITLE
local Logo = Instance.new("ImageLabel")
Logo.Size = UDim2.new(1, 0, 0, 150)
Logo.Image = "rbxassetid://17355005862"
Logo.BackgroundTransparency = 1
Logo.ScaleType = Enum.ScaleType.Fit
Logo.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 155)
Title.Text = "Brandon Hub"
Title.TextColor3 = Color3.fromRGB(135, 206, 235)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.Parent = Main

-- SPEED INPUT
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.9, 0, 0, 40)
SpeedInput.Position = UDim2.new(0.05, 0, 0, 195)
SpeedInput.PlaceholderText = "Enter Speed & Press Enter"
SpeedInput.Text = ""
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Parent = Main
SpeedInput.FocusLost:Connect(function()
    currentSpeed = tonumber(SpeedInput.Text) or 50
end)

-- BUTTON CREATOR
local function makeBtn(name, pos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name .. ": OFF"
    btn.TextColor
