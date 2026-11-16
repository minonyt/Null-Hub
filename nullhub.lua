-- ================= CONFIG =================
local HUB_NAME = "NULL-HUB"                
local KEY_LINK = "https://your-link-here" -- the link that gets copied
---------------------------------------------

local Players = game:GetService("Players")
local player  = Players:WaitForChild("LocalPlayer")

local gui = Instance.new("ScreenGui")
gui.Name = "KeyHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 280, 0, 140)
main.Position = UDim2.new(0.5, -140, 0.5, -70)
main.BackgroundColor3 = Color3.fromRGB(18, 10, 26)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(122, 58, 205)
stroke.Thickness = 1

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 8)
title.BackgroundTransparency = 1
title.Text = HUB_NAME
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(199, 154, 255)
title.Parent = main

-- Key input
local input = Instance.new("TextBox")
input.Size = UDim2.new(1, -24, 0, 34)
input.Position = UDim2.new(0, 12, 0, 46)
input.BackgroundColor3 = Color3.fromRGB(32, 20, 44)
input.PlaceholderText = "input key"
input.PlaceholderColor3 = Color3.fromRGB(128, 96, 160)
input.TextColor3 = Color3.fromRGB(232, 224, 240)
input.Font = Enum.Font.Gotham
input.TextSize = 15
input.ClearTextOnFocus = false
input.Parent = main
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

-- Get key button
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(1, -24, 0, 34)
btn.Position = UDim2.new(0, 12, 0, 90)
btn.BackgroundColor3 = Color3.fromRGB(96, 44, 165)
btn.Text = "get key"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 16
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = main
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

local function copy()
    local ok = pcall(setclipboard, KEY_LINK)
    if ok then input.Text = KEY_LINK end
    btn.Text = "copied!"
    task.delay(1.2, function()
        btn.Text = "get key"
    end)
end

btn.MouseButton1Click:Connect(copy)
