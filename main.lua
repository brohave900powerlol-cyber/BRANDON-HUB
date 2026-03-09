-- BRANDON HUB SPEED BOOSTER ⚡️
-- MADE BY BRANDON HUB
-- DISCORD: https://discord.gg/xunwv9mwTJ

print("----------------------------")
print("BRANDON HUB LOADED ⚡️")
print("JOIN THE DISCORD: xunwv9mwTJ")
print("----------------------------")

local LP = game.Players.LocalPlayer
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- // CLEANUP // --
if CoreGui:FindFirstChild("BrandonSpeedV33") then CoreGui.BrandonSpeedV33:Destroy() end

local Screen = Instance.new("ScreenGui", CoreGui)
Screen.Name = "BrandonSpeedV33"

-- // DRAG ENGINE // --
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- // OPEN/CLOSE BUTTON // --
local OpenBtn = Instance.new("TextButton", Screen)
OpenBtn.Size = UDim2.new(0, 50, 0, 50); OpenBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 20); OpenBtn.Text = "⚡️"; OpenBtn.TextColor3 = Color3.fromRGB(0, 180, 255); OpenBtn.Font = Enum.Font.GothamBold; OpenBtn.TextSize = 25
Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1, 0)
local OStroke = Instance.new("UIStroke", OpenBtn); OStroke.Color = Color3.fromRGB(0, 200, 255); OStroke.Thickness = 2
MakeDraggable(OpenBtn)

-- // MAIN FRAME // --
local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 230, 0, 210); Main.Position = UDim2.new(0.5, -115, 0.5, -105)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 15); Main.Visible = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)
local Glow = Instance.new("UIStroke", Main); Glow.Color = Color3.fromRGB(0, 180, 255); Glow.Thickness = 2.5
MakeDraggable(Main)

OpenBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

-- UI Content
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40); Title.Text = "BRANDON HUB SPEED BOOSTER ⚡️"; Title.TextColor3 = Color3.new(1, 1, 1); Title.Font = Enum.Font.GothamBold; Title.TextSize = 11; Title.BackgroundTransparency = 1

local Input = Instance.new("TextBox", Main)
Input.Size = UDim2.new(0.8, 0, 0, 35); Input.Position = UDim2.new(0.1, 0, 0.22, 0); Input.BackgroundColor3 = Color3.fromRGB(25, 25, 30); Input.PlaceholderText = "Boost Power (1-100)"; Input.Text = "60"; Input.TextColor3 = Color3.new(1, 1, 1); Input.Font = Enum.Font.GothamMedium; Input.TextSize = 14
Instance.new("UICorner", Input).CornerRadius = UDim.new(0, 6)

local Toggle = Instance.new("TextButton", Main)
Toggle.Size = UDim2.new(0.8, 0, 0, 40); Toggle.Position = UDim2.new(0.1, 0, 0.45, 0); Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 35); Toggle.Text = "ACTIVATE BOOST"; Toggle.TextColor3 = Color3.new(0.7, 0.7, 0.7); Toggle.Font = Enum.Font.GothamBold; Toggle.TextSize = 14
Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

local CopyBtn = Instance.new("TextButton", Main)
CopyBtn.Size = UDim2.new(0.8, 0, 0, 30); CopyBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
CopyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45); CopyBtn.Text = "COPY DISCORD LINK"
CopyBtn.TextColor3 = Color3.fromRGB(200, 200, 200); CopyBtn.Font = Enum.Font.GothamBold; CopyBtn.TextSize = 10
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)

local Credits = Instance.new("TextLabel", Main)
Credits.Size = UDim2.new(1, 0, 0, 20); Credits.Position = UDim2.new(0, 0, 0.88, 0); Credits.Text = "MADE BY BRANDON HUB"; Credits.TextColor3 = Color3.fromRGB(120, 120, 120); Credits.Font = Enum.Font.GothamMedium; Credits.TextSize = 9; Credits.BackgroundTransparency = 1

-- // LOGIC // --
CopyBtn.MouseButton1Click:Connect(function()
    local link = "https://discord.gg/xunwv9mwTJ"
    if setclipboard then setclipboard(link) end
    CopyBtn.Text = "COPIED!"; task.wait(2); CopyBtn.Text = "COPY DISCORD LINK"
end)

local BoostPower = 60
local Active = false

Toggle.MouseButton1Click:Connect(function()
    Active = not Active
    BoostPower = tonumber(Input.Text) or 60
    Toggle.Text = Active and "BOOST ACTIVE ⚡" or "ACTIVATE BOOST"
    Toggle.BackgroundColor3 = Active and Color3.fromRGB(0, 140, 255) or Color3.fromRGB(30, 30, 35)
    Glow.Color = Active and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(0, 180, 255)
end)

RS.RenderStepped:Connect(function()
    if Active then
        pcall(function()
            local Char = LP.Character
            local Hum = Char and Char:FindFirstChildOfClass("Humanoid")
            local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
            if Hum and HRP and Hum.MoveDirection.Magnitude > 0 then
                HRP.AssemblyLinearVelocity = Vector3.new(Hum.MoveDirection.X * BoostPower, HRP.AssemblyLinearVelocity.Y, Hum.MoveDirection.Z * BoostPower)
            end
        end)
    end
end)
