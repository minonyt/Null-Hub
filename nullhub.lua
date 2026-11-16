-- ================= CONFIG =================
local HUB_NAME = "VOIDHUB"                -- your edgy hub name (ending in "hub")
local KEY_LINK = "https://your-link-here" -- the link that gets copied to the clipboard
---------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Name = "KeyHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ============ Backdrop (dark panel + lightning) ============
local backdrop = Instance.new("Frame")
backdrop.Name = "Backdrop"
backdrop.Size = UDim2.new(0, 480, 0, 300)
backdrop.Position = UDim2.new(0.5, -240, 0.5, -150)
backdrop.BackgroundColor3 = Color3.fromRGB(8, 4, 14)
backdrop.BackgroundTransparency = 0.45
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 1
backdrop.Parent = gui
Instance.new("UICorner", backdrop).CornerRadius = UDim.new(0, 14)
Instance.new("UIClipFrames", backdrop)
local bStroke = Instance.new("UIStroke", backdrop)
bStroke.Color = Color3.fromRGB(122, 58, 205)
bStroke.Thickness = 1.5
bStroke.Transparency = 0.3

-- small purple lightning flickers (random thin bolts that flash + fade)
local function spawnBolt()
    local w = math.random(2, 3)
    local h = math.random(20, 80)

    local bolt = Instance.new("Frame")
    bolt.Name = "Bolt"
    bolt.Parent = backdrop
    bolt.ZIndex = 2
    bolt.AnchorPoint = Vector2.new(0.5, 0)
    bolt.Size = UDim2.new(0, w, 0, h)
    bolt.Position = UDim2.new(math.random(0.05, 0.95), -w / 2, math.random(0.05, 0.6), 0)
    bolt.BackgroundColor3 = Color3.fromRGB(190, 140, 255)
    bolt.BorderSizePixel = 0
    bolt.BackgroundTransparency = 1
    Instance.new("UICorner", bolt).CornerRadius = UDim.new(0, 2)

    TweenService:Create(bolt, TweenInfo.new(0.06, Enum.EasingStyle.Sine), { BackgroundTransparency = 0 }):Play()
    task.wait(0.06)
    TweenService:Create(bolt, TweenInfo.new(0.18, Enum.EasingStyle.Sine), { BackgroundTransparency = 1 }):Play()
    task.wait(0.18)
    bolt:Destroy()
end

task.spawn(function()
    while true do
        spawnBolt()
        task.wait(math.random(0.15, 0.6))
    end
end)

-- ============ Main panel ============
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 340, 0, 190)
main.Position = UDim2.new(0.5, -170, 0.5, -95)
main.BackgroundColor3 = Color3.fromRGB(18, 10, 26)
main.BackgroundTransparency = 0.15
main.BorderSizePixel = 0
main.ZIndex = 3
main.Parent = gui
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(122, 58, 205)
stroke.Thickness = 1

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 32)
title.Position = UDim2.new(0, 0, 0, 14)
title.ZIndex = 4
title.BackgroundTransparency = 1
title.Text = HUB_NAME
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextColor3 = Color3.fromRGB(199, 154, 255)
title.Parent = main

-- Key input (empty by default, just shows the placeholder)
local input = Instance.new("TextBox")
input.Name = "KeyInput"
input.Size = UDim2.new(1, -28, 0, 40)
input.Position = UDim2.new(0, 14, 0, 58)
input.ZIndex = 4
input.BackgroundColor3 = Color3.fromRGB(32, 20, 44)
input.BorderSizePixel = 0
input.Text = ""
input.PlaceholderText = "input key"
input.PlaceholderColor3 = Color3.fromRGB(128, 96, 160)
input.TextColor3 = Color3.fromRGB(232, 224, 240)
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.ClearTextOnFocus = false
input.Parent = main
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)

-- Get key button
local btn = Instance.new("TextButton")
btn.Name = "GetKey"
btn.Size = UDim2.new(1, -28, 0, 40)
btn.Position = UDim2.new(0, 14, 0, 110)
btn.ZIndex = 4
btn.BackgroundColor3 = Color3.fromRGB(96, 44, 165)
btn.BorderSizePixel = 0
btn.Text = "get key"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 17
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = main
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

-- Robust clipboard write (executor APIs vary; try the common ones)
local function copy()
    local ok = false
    if type(setclipboard) == "function" then
        ok = pcall(setclipboard, KEY_LINK)
    end
    if not ok and type(clipboard) == "table" and type(clipboard.set) == "function" then
        ok = pcall(clipboard.set, KEY_LINK)
    end
    btn.Text = ok and "copied!" or "clip error"
    task.delay(1.2, function()
        btn.Text = "get key"
    end)
end

btn.MouseButton1Click:Connect(copy)
