-- ================= CONFIG =================
local HUB_NAME    = "VOIDHUB"                  -- your edgy hub name
local HUB_VERSION = "v1.0.3"                   -- version badge (looks legit)
local KEY_LINK    = "https://your-link-here"   -- link copied to clipboard
---------------------------------------------

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Name = "KeyHub"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- ============ Backdrop (thin glow ring hugging the panel) ============
local backdrop = Instance.new("Frame")
backdrop.Name = "Backdrop"
backdrop.Size = UDim2.new(0, 348, 0, 228)
backdrop.Position = UDim2.new(0.5, -174, 0.5, -114)
backdrop.BackgroundColor3 = Color3.fromRGB(9, 5, 16)
backdrop.BackgroundTransparency = 1
backdrop.BorderSizePixel = 0
backdrop.ZIndex = 1
backdrop.Parent = gui

local bgGrad = Instance.new("UIGradient", backdrop)
bgGrad.Transparency = NumberSequence.new(0)
bgGrad.Rotation = 45
bgGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(9, 5, 16)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 15, 54)),
})
Instance.new("UICorner", backdrop).CornerRadius = UDim.new(0, 14)
local bStroke = Instance.new("UIStroke", backdrop)
bStroke.Color = Color3.fromRGB(122, 58, 205)
bStroke.Thickness = 1.5
bStroke.Transparency = 1

-- ============ Main panel ============
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 300, 0, 188)          -- intro start size, pops to 320x204
main.Position = UDim2.new(0.5, -150, 0.5, -94) -- intro start pos, settles at -160/-102
main.BackgroundColor3 = Color3.fromRGB(18, 10, 28)
main.BackgroundTransparency = 1
main.BorderSizePixel = 0
main.ZIndex = 3
main.Parent = gui

local panelGrad = Instance.new("UIGradient", main)
panelGrad.Transparency = NumberSequence.new(0)
panelGrad.Rotation = 90
panelGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(24, 14, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 8, 22)),
})
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(140, 80, 230)
mainStroke.Thickness = 1
mainStroke.Transparency = 1

-- Drag strip (top of the panel; grab the grip pill to move it)
local dragStrip = Instance.new("Frame")
dragStrip.Name = "DragStrip"
dragStrip.Size = UDim2.new(1, 0, 0, 30)
dragStrip.BackgroundTransparency = 1
dragStrip.BorderSizePixel = 0
dragStrip.ZIndex = 5
dragStrip.Parent = main

local grip = Instance.new("Frame")
grip.Name = "Grip"
grip.Size = UDim2.new(0, 40, 0, 5)
grip.Position = UDim2.new(0.5, -20, 0, 12)
grip.BackgroundColor3 = Color3.fromRGB(170, 110, 255)
grip.BackgroundTransparency = 1
grip.BorderSizePixel = 0
grip.ZIndex = 6
grip.Parent = dragStrip
Instance.new("UICorner", grip).CornerRadius = UDim.new(1, 0)

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(0, 170, 0, 28)
title.Position = UDim2.new(0, 14, 0, 34)
title.ZIndex = 4
title.BackgroundTransparency = 1
title.Text = HUB_NAME
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(210, 170, 255)
title.TextTransparency = 1
title.Parent = main

-- Version badge
local version = Instance.new("Frame")
version.Name = "Version"
version.Size = UDim2.new(0, 54, 0, 18)
version.Position = UDim2.new(1, -68, 0, 34)
version.BackgroundColor3 = Color3.fromRGB(110, 50, 200)
version.BackgroundTransparency = 1
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
versionLabel.TextTransparency = 1
versionLabel.ZIndex = 5
versionLabel.Parent = version

-- Tagline
local tagline = Instance.new("TextLabel")
tagline.Name = "Tagline"
tagline.Size = UDim2.new(1, -28, 0, 14)
tagline.Position = UDim2.new(0, 14, 0, 66)
tagline.ZIndex = 4
tagline.BackgroundTransparency = 1
tagline.Text = "unofficial • key access system"
tagline.Font = Enum.Font.Gotham
tagline.TextSize = 11
tagline.TextXAlignment = Enum.TextXAlignment.Left
tagline.TextColor3 = Color3.fromRGB(150, 130, 185)
tagline.TextTransparency = 1
tagline.Parent = main

-- Key input (empty by default, centered text/placeholder)
local input = Instance.new("TextBox")
input.Name = "KeyInput"
input.Size = UDim2.new(1, -28, 0, 38)
input.Position = UDim2.new(0, 14, 0, 88)
input.ZIndex = 4
input.BackgroundColor3 = Color3.fromRGB(30, 18, 44)
input.BackgroundTransparency = 1
input.BorderSizePixel = 0
input.Text = ""
input.PlaceholderText = "Input Key"
input.PlaceholderColor3 = Color3.fromRGB(128, 96, 160)
input.TextColor3 = Color3.fromRGB(232, 224, 240)
input.Font = Enum.Font.Gotham
input.TextSize = 15
input.TextXAlignment = Enum.TextXAlignment.Center
input.ClearTextOnFocus = false
input.Parent = main
Instance.new("UICorner", input).CornerRadius = UDim.new(0, 6)
local iStroke = Instance.new("UIStroke", input)
iStroke.Color = Color3.fromRGB(122, 58, 205)
iStroke.Thickness = 1
iStroke.Transparency = 1

-- Get key / check key button
local BTN_BASE = Color3.fromRGB(96, 44, 165)
local BTN_HOVER = Color3.fromRGB(140, 80, 230)

local btn = Instance.new("TextButton")
btn.Name = "GetKey"
btn.Size = UDim2.new(1, -28, 0, 38)
btn.Position = UDim2.new(0, 14, 0, 136)
btn.ZIndex = 4
btn.BackgroundColor3 = BTN_BASE
btn.BackgroundTransparency = 1
btn.BorderSizePixel = 0
btn.Text = "Get Key"
btn.Font = Enum.Font.GothamBold
btn.TextSize = 16
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.TextTransparency = 1
btn.Parent = main
Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
local btnGlow = Instance.new("UIStroke", btn)
btnGlow.Color = Color3.fromRGB(170, 110, 255)
btnGlow.Thickness = 2
btnGlow.Transparency = 1

btn.MouseEnter:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = BTN_HOVER }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.15), { Transparency = 0.2 }):Play()
end)
btn.MouseLeave:Connect(function()
    TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = BTN_BASE }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.15), { Transparency = 0.8 }):Play()
end)

-- Copy burst: little sparks that fly out from wherever the cursor clicked
local function fireSparks(mx, my)
    local mouseFrame = player:GetMouse()
    -- click position relative to the panel (panel is centered + drag offset)
    local startX = mouseFrame.CanvasSize.X / 2 + main.Position.X.Offset - 160
    local startY = mouseFrame.CanvasSize.Y / 2 + main.Position.Y.Offset - my

    for _ = 1, 12 do
        local spark = Instance.new("Frame")
        spark.Name = "Spark"
        spark.Parent = main
        spark.ZIndex = 8
        spark.AnchorPoint = Vector2.new(0.5, 0.5)
        spark.Size = UDim2.new(0, 5, 0, 5)
        spark.BackgroundColor3 = Color3.fromRGB(190, 140, 255)
        spark.BorderSizePixel = 0
        spark.Position = UDim2.new(0, startX, 0, startY)
        Instance.new("UICorner", spark).CornerRadius = UDim.new(1, 0)

        local dx = math.random(-90, 90)
        local dy = -math.random(50, 130)
        TweenService:Create(spark, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, startX + dx, 0, startY + dy),
            BackgroundTransparency = 1,
        }):Play()
        task.delay(0.55, function()
            spark:Destroy()
        end)
    end
end

-- Footer
local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.Size = UDim2.new(1, -28, 0, 14)
footer.Position = UDim2.new(0, 14, 0, 186)
footer.ZIndex = 4
footer.BackgroundTransparency = 1
footer.Text = "© " .. HUB_NAME .. " • unofficial • free"
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextColor3 = Color3.fromRGB(110, 92, 150)
footer.TextTransparency = 1
footer.Parent = main

-- ============ Button state logic (after btn exists) ============
local transientUntil = 0

local function refreshBtnText()
    if #input.Text > 12 then
        btn.Text = "Check Key"
    else
        btn.Text = "Get Key"
    end
end

-- auto-switch the button the instant the typed text passes 12 chars
input:GetPropertyChangedSignal("Text"):Connect(refreshBtnText)

-- bulletproof reset ticker: clears transient messages ("Copied!", "Invalid Key!", ...)
RunService.RenderStepped:Connect(function()
    if transientUntil > 0 and tick() >= transientUntil then
        transientUntil = 0
        pcall(refreshBtnText)
    end
end)

-- ============ Intro (pop-in, staggered) ============
local function fadeProp(el, prop, target, delay)
    task.delay(delay, function()
        TweenService:Create(el, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { [prop] = target }):Play()
    end)
end

task.spawn(function()
    TweenService:Create(backdrop, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0.55 }):Play()
    TweenService:Create(bStroke, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 0.4 }):Play()

    TweenService:Create(main, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 204),
        Position = UDim2.new(0.5, -160, 0.5, -102),
        BackgroundTransparency = 0,
    }):Play()
    TweenService:Create(mainStroke, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Transparency = 0.15 }):Play()

    fadeProp(title, "TextTransparency", 0, 0.15)
    fadeProp(version, "BackgroundTransparency", 0, 0.2)
    fadeProp(versionLabel, "TextTransparency", 0, 0.2)
    fadeProp(tagline, "TextTransparency", 0, 0.25)
    fadeProp(input, "BackgroundTransparency", 0, 0.3)
    fadeProp(input, "TextTransparency", 0, 0.3)
    fadeProp(iStroke, "Transparency", 0.5, 0.3)
    fadeProp(btn, "BackgroundTransparency", 0, 0.35)
    fadeProp(btn, "TextTransparency", 0, 0.35)
    fadeProp(btnGlow, "Transparency", 0.8, 0.35)
    fadeProp(footer, "TextTransparency", 0, 0.4)
    fadeProp(grip, "BackgroundTransparency", 0.3, 0.45)
end)

-- ============ Pulsing border glow ============
task.spawn(function()
    task.wait(1)
    while true do
        TweenService:Create(mainStroke, TweenInfo.new(1.6, Enum.EasingStyle.Sine), { Transparency = 0.6 }):Play()
        task.wait(1.6)
        TweenService:Create(mainStroke, TweenInfo.new(1.6, Enum.EasingStyle.Sine), { Transparency = 0.15 }):Play()
        task.wait(1.6)
    end
end)

-- ============ Drag (grab the grip pill) ============
dragStrip.MouseEnter:Connect(function()
    pcall(function()
        player:GetMouse().CursorIcon = Enum.MouseCursorIcon.Hand
    end)
end)
dragStrip.MouseLeave:Connect(function()
    pcall(function()
        player:GetMouse().CursorIcon = Enum.MouseCursorIcon.Arrow
    end)
end)

dragStrip.InputBegan:Connect(function(inputType)
    if inputType.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    local mouse = player:GetMouse()
    local startX = main.Position.X.Offset
    local startY = main.Position.Y.Offset
    local mx0, my0 = mouse.X, mouse.Y
    local cx = math.max(0, mouse.CanvasSize.X / 2 - 160)
    local cy = math.max(0, mouse.CanvasSize.Y / 2 - 102)
    pcall(function()
        mouse.CursorIcon = Enum.MouseCursorIcon.SizeAll
    end)

    local moved = mouse.Moved:Connect(function(mx, my)
        main.Position = UDim2.new(0.5,
            math.clamp(startX + (mx - mx0), -cx, cx),
            0.5,
            math.clamp(startY + (my - my0), -cy, cy))
    end)
    local up = mouse.Button1Up:Connect(function()
        moved:Disconnect()
        up:Disconnect()
        pcall(function()
            player:GetMouse().CursorIcon = Enum.MouseCursorIcon.Arrow
        end)
    end)
end)

-- ============ Clipboard / Key check ============
local function copy()
    local mouseFrame = player:GetMouse()

    -- "Check Key" mode: anything over 12 chars is (for now) always invalid
    if #input.Text > 12 then
        btn.Text = "Invalid Key!"
        transientUntil = tick() + 1.2
        return
    end

    local px, py = 160, 155 -- fallback: button center
    pcall(function()
        local x, y = mouseFrame:GetPosition()
        px, py = x, y
    end)

    local ok = false
    pcall(function()
        if type(setclipboard) == "function" then
            ok = pcall(setclipboard, KEY_LINK)
        end
        if not ok and type(clipboard) == "table" and type(clipboard.set) == "function" then
            ok = pcall(clipboard.set, KEY_LINK)
        end
    end)

    btn.Text = ok and "Copied!" or "Clip Error"
    transientUntil = tick() + 1.2

    if ok then
        pcall(function()
            fireSparks(px, py)
        end)
    end
end

btn.MouseButton1Click:Connect(copy)
