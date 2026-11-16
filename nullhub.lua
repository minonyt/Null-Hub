-- ================= CONFIG =================
local HUB_NAME    = "VOIDHUB"                  -- your edgy hub name
local HUB_VERSION = "v1.0.3"                   -- version badge (looks legit)
local KEY_LINK    = "https://your-link-here"   -- link copied to clipboard
---------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Name = "KeyHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ============ Backdrop ============
local backdrop = Instance.new("Frame")
backdrop.Name = "Backdrop"
backdrop.Size = UDim2.new(0, 500, 0, 330)
backdrop.Position = UDim2.new(0.5, -250, 0.5, -165)
backdrop.BackgroundColor3 = Color3.fromRGB(9, 5, 16)
backdrop.BackgroundTransparency = 0.6
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 1
backdrop.Parent = gui

local bgGrad = Instance.new("UIGradient", backdrop)
bgGrad.Rotation = 45
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(9, 5, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 15, 54)),
})
Instance.new("UICorner", backdrop).CornerRadius = UDim.new(0, 14)
local bStroke = Instance.new("UIStroke", backdrop)
bStroke.Color = Color3.fromRGB(122, 58, 205)
bStroke.Thickness = 1.5
bStroke.Transparency = 0.45

-- small purple lightning flickers, top-left corner of the backdrop
local function spawnBolt()
    local w = math.random(2, 3)
    local h = math.random(12, 40)

    local bolt = Instance.new("Frame")
    bolt.Name = "Bolt"
    bolt.Parent = backdrop
    bolt.ZIndex = 2
    bolt.BorderSizePixel = 0
    bolt.BackgroundColor3 = Color3.fromRGB(170, 110, 255)
    bolt.BackgroundTransparency = 1
    bolt.Size = UDim2.new(0, w, 0, h)
    bolt.Position = UDim2.new(0, math.random(4, 180), 0, math.random(4, 160))

    Instance.new("UICorner", bolt).CornerRadius = UDim.new(0, 2)
    local glow = Instance.new("UIStroke", bolt)
    glow.Color = Color3.fromRGB(150, 90, 255)
    glow.Thickness = 2
    glow.Transparency = 0.5

    TweenService:Create(bolt, TweenInfo.new(0.05, Enum.EasingStyle.Sine), { BackgroundTransparency = 0 }):Play()
    TweenService:Create(glow, TweenInfo.new(0.05, Enum.EasingStyle.Sine), { Transparency = 0.15 }):Play()
    task.wait(0.08)
    TweenService:Create(bolt, TweenInfo.new(0.2, Enum.EasingStyle.Sine), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(glow, TweenInfo.new(0.2, Enum.EasingStyle.Sine), { Transparency = 1 }):Play()
    task.wait(0.25)
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
main.Size = UDim2.new(0, 420, 0, 250)
main.Position = UDim2.new(0.5, -210, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(18, 10, 28)
main.BorderSizePixel = 0
main.ZIndex = 3
main.Parent = gui

local panelGrad = Instance.new("UIGradient", main)
panelGrad.Rotation = 90
panelGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 14, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 8, 22)),
})
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(140, 80, 230)
stroke.Thickness = 1
stroke.Transparency = 0.15

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0.55, 0, 0, 32)
title.Position = UDim2.new(0, 16, 0, 16)
title.ZIndex = 4
title.BackgroundTransparency = 1
title.Text = HUB_NAME
title.Font = Enum.Font.GothamBlack
title.TextSize = 30
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(210, 170, 255)
title.Parent = main

-- Version badge
local version = Instance.new("Frame")
version.Name = "Version"
version.Size = UDim2.new(0, 54, 0, 18)
version.Position = UDim2.new(1, -70, 0, 20)
version.BackgroundColor3 = Color3.fromRGB(110, 50, 200)
version.BorderSizePixel = 0
version.ZIndex = 4
version.Parent = main
Instance.new("UICorner", version).CornerRadius = UDim.new(0, 9)

local versionLabel = Instance.new("TextLabel")
versionLabel.Name = "VersionLabel"
versionLabel.Size = UDim2.new(1, 0, 1, 0)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = HUB_VERSION
versionLabel.Font = Enum.Font.GothamBold
versionLabel.TextSize = 12
versionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
versionLabel.ZIndex = 5
versionLabel.Parent = version

-- Tagline
local tagline = Instance.new("TextLabel")
tagline.Name = "Tagline"
tagline.Size = UDim2.new(1, -32, 0, 16)
tagline.Position = UDim2.new(0, 16, 0, 50)
tagline.ZIndex = 4
tagline.BackgroundTransparency = 1
tagline.Text = "unofficial • key access system"
tagline.Font = Enum.Font.Gotham
tagline.TextSize = 11
tagline.TextXAlignment = Enum.TextXAlignment.Left
tagline.TextColor3 = Color3.fromRGB(150, 130, 185)
tagline.Parent = main

-- Key input (empty by default, just shows the centered placeholder)
local input = Instance.new("TextBox")
input.Name = "KeyInput"
input.Size = UDim2.new(1, -32, 0, 44)
input.Position = UDim2.new(0, 16, 0, 74)
input.ZIndex = 4
input.BackgroundColor3 = Color3.fromRGB(30, 18, 44)
input.BorderSizePixel = 0
input.Text = ""
input.PlaceholderText = "Input Key"
input.PlaceholderColor3 = Color3.fromRGB(128, 96, 160)
input.TextColor3 = Color3.fromRGB(232, 224, 240)
input.Font = Enum.Font.Gotham
input.TextSize = 16
input.ClearTextOnFocus = false
input.Parent = main
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
local iStroke = Instance.new("UIStroke", input)
iStroke.Color = Color3.fromRGB(122, 58, 205)
iStroke.Thickness = 1
iStroke.Transparency = 0.5

pcall(function()
    input.PlaceholderTextXAlignment = Enum.TextXAlignment.Center
end)

-- Get key button
local BTN_BASE = Color3.fromRGB(96, 44, 165)
local BTN_HOVER = Color3.fromRGB(140, 80, 230)

local btn = Instance.new("TextButton")
btn.Name = "GetKey"
btn.Size = UDim2.new(1, -32, 0, 44)
btn.Position = UDim2.new(0, 16, 0, 132)
btn.ZIndex = 4
btn.BackgroundColor3 = BTN_BASE
btn.BorderSizePixel = 0
btn.Text = "Get Key"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 17
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = main
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
local btnGlow = Instance.new("UIStroke", btn)
btnGlow.Color = Color3.fromRGB(170, 110, 255)
btnGlow.Thickness = 2
btnGlow.Transparency = 0.8

btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = BTN_HOVER }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.15), { Transparency = 0.2 }):Play()
end)
btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = BTN_BASE }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.15), { Transparency = 0.8 }):Play()
end)

-- Footer
local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.Size = UDim2.new(1, -32, 0, 14)
footer.Position = UDim2.new(0, 16, 0, 216)
footer.ZIndex = 4
footer.BackgroundTransparency = 1
footer.Text = "© " .. HUB_NAME .. " • unofficial • free"
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextColor3 = Color3.fromRGB(110, 92, 150)
footer.Parent = main

-- Robust clipboard write (executor APIs vary; try the common ones)
local function copy()
    local ok = false
    if type(setclipboard) == "function" then
        ok = pcall(setclipboard, KEY_LINK)
    end
    if not ok and type(clipboard) == "table" and type(clipboard.set) == "function" then
        ok = pcall(clipboard.set, KEY_LINK)
    end
    btn.Text = ok and "Copied!" or "Clip Error"
    task.delay(1.2, function()
        btn.Text = "Get Key"
    end)
end

btn.MouseButton1Click:Connect(copy)
