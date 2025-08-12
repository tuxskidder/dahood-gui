-- Tux's Keyless Menu
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuxsKeylessMenu"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 200, 0, 500)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(128, 0, 128) -- Purple color
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Tux's Keyless Menu"
Title.TextScaled = true
Title.Parent = MainFrame

-- Fly Toggle
local FlyToggle = Instance.new("TextButton")
FlyToggle.Size = UDim2.new(1, 0, 0, 40)
FlyToggle.Position = UDim2.new(0, 0, 0, 50)
FlyToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FlyToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyToggle.Text = "Fly"
FlyToggle.Parent = MainFrame

local isFlying = false

FlyToggle.MouseButton1Click:Connect(function()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    local BodyVelocity = Instance.new("BodyVelocity")
    BodyVelocity.Velocity = Vector3.new(0, 50, 0)
    BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
    BodyVelocity.Parent = Character:WaitForChild("HumanoidRootPart")

    isFlying = not isFlying
    if isFlying then
        FlyToggle.Text = "Fly (On)"
    else
        FlyToggle.Text = "Fly (Off)"
        BodyVelocity:Destroy()
    end
end)

-- NoClip Toggle
local NoClipToggle = Instance.new("TextButton")
NoClipToggle.Size = UDim2.new(1, 0, 0, 40)
NoClipToggle.Position = UDim2.new(0, 0, 0, 90)
NoClipToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NoClipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NoClipToggle.Text = "NoClip"
NoClipToggle.Parent = MainFrame

local isNoClipping = false

NoClipToggle.MouseButton1Click:Connect(function()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")

    isNoClipping = not isNoClipping
    if isNoClipping then
        NoClipToggle.Text = "NoClip (On)"
        Humanoid.PlatformStand = true
    else
        NoClipToggle.Text = "NoClip (Off)"
        Humanoid.PlatformStand = false
    end
end)

-- RGB Menu Toggle
local RGBMenuToggle = Instance.new("TextButton")
RGBMenuToggle.Size = UDim2.new(1, 0, 0, 40)
RGBMenuToggle.Position = UDim2.new(0, 0, 0, 130)
RGBMenuToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
RGBMenuToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
RGBMenuToggle.Text = "RGB M3NU"
RGBMenuToggle.Parent = MainFrame

local isRGBMenuOpen = false

RGBMenuToggle.MouseButton1Click:Connect(function()
    isRGBMenuOpen = not isRGBMenuOpen
    if isRGBMenuOpen then
        RGBMenuToggle.Text = "RGB M3NU (Open)"
        -- Implement RGB menu functionality
    else
        RGBMenuToggle.Text = "RGB M3NU (Closed)"
    end
end)

-- Visit Discord Button
local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(1, 0, 0, 40)
DiscordButton.Position = UDim2.new(0, 0, 0, 170)
DiscordButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordButton.Text = "Visit Discord"
DiscordButton.Parent = MainFrame

DiscordButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/4F7rMQtGhe")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord Link",
        Text = "Link copied to clipboard!",
        Duration = 5
    })
end)

-- Speedwalk Slider
local SpeedwalkSlider = Instance.new("TextButton")
SpeedwalkSlider.Size = UDim2.new(1, 0, 0, 40)
SpeedwalkSlider.Position = UDim2.new(0, 0, 0, 210)
SpeedwalkSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SpeedwalkSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedwalkSlider.Text = "Speedwalk"
SpeedwalkSlider.Parent = MainFrame

local speedwalkValue = 16

SpeedwalkSlider.MouseButton1Click:Connect(function()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    speedwalkValue = speedwalkValue + 4
    if speedwalkValue > 100 then
        speedwalkValue = 16
    end
    Humanoid.WalkSpeed = speedwalkValue
    SpeedwalkSlider.Text = "Speedwalk: " .. speedwalkValue
end)

-- Jumpboost Slider
local JumpboostSlider = Instance.new("TextButton")
JumpboostSlider.Size = UDim2.new(1, 0, 0, 40)
JumpboostSlider.Position = UDim2.new(0, 0, 0, 250)
JumpboostSlider.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
JumpboostSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
JumpboostSlider.Text = "Jumpboost"
JumpboostSlider.Parent = MainFrame

local jumpboostValue = 50

JumpboostSlider.MouseButton1Click:Connect(function()
    local Player = game.Players.LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    jumpboostValue = jumpboostValue + 10
    if jumpboostValue > 100 then
        jumpboostValue = 50
    end
    Humanoid.JumpPower = jumpboostValue
    JumpboostSlider.Text = "Jumpboost: " .. jumpboostValue
end)

-- ESP Toggle
local ESPToggle = Instance.new("TextButton")
ESPToggle.Size = UDim2.new(1, 0, 0, 40)
ESPToggle.Position = UDim2.new(0, 0, 0, 290)
ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ESPToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPToggle.Text = "ESP"
ESPToggle.Parent = MainFrame

local isESPEnabled = false

ESPToggle.MouseButton1Click:Connect(function()
    isESPEnabled = not isESPEnabled
    if isESPEnabled then
        ESPToggle.Text = "ESP (On)"
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local Character = player.Character
                if Character then
                    local Box = Drawing.new("Square")
                    Box.Visible = true
                    Box.Color = Color3.fromRGB(255, 0, 0)
                    Box.Thickness = 2
                    Box.Filled = false
                    Box.Size = Vector2.new(2000, 2000)
                    Box.Position = Vector2.new(Character.HumanoidRootPart.Position.X, Character.HumanoidRootPart.Position.Y)

                    game:GetService("RunService").RenderStepped:Connect(function()
                        Box.Position = Vector2.new(Character.HumanoidRootPart.Position.X, Character.HumanoidRootPart.Position.Y)
                    end)
                end
            end
        end
    else
        ESPToggle.Text = "ESP (Off)"
        -- Clear ESP boxes
        for _, drawing in ipairs(Drawing:GetChildren()) do
            if drawing:IsA("Square") then
                drawing:Remove()
            end
        end
    end
end)

-- Aimbot Toggle
local AimbotToggle = Instance.new("TextButton")
AimbotToggle.Size = UDim2.new(1, 0, 0, 40)
AimbotToggle.Position = UDim2.new(0, 0, 0, 330)
AimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AimbotToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotToggle.Text = "Aimbot"
AimbotToggle.Parent = MainFrame

local isAimbotEnabled = false

AimbotToggle.MouseButton1Click:Connect(function()
    isAimbotEnabled = not isAimbotEnabled
    if isAimbotEnabled then
        AimbotToggle.Text = "Aimbot (On)"
        -- Implement Aimbot functionality
    else
        AimbotToggle.Text = "Aimbot (Off)"
    end
end)

-- Silent Aim Toggle
local SilentAimToggle = Instance.new("TextButton")
SilentAimToggle.Size = UDim2.new(1, 0, 0, 40)
SilentAimToggle.Position = UDim2.new(0, 0, 0, 370)
SilentAimToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SilentAimToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SilentAimToggle.Text = "Silent Aim"
SilentAimToggle.Parent = MainFrame

local isSilentAimEnabled = false

SilentAimToggle.MouseButton1Click:Connect(function()
    isSilentAimEnabled = not isSilentAimEnabled
    if isSilentAimEnabled then
        SilentAimToggle.Text = "Silent Aim (On)"
        -- Implement Silent Aim functionality
    else
        SilentAimToggle.Text = "Silent Aim (Off)"
    end
end)

-- Additional Mods Section
local AdditionalModsSection = Instance.new("Frame")
AdditionalModsSection.Size = UDim2.new(1, 0, 0, 100)
AdditionalModsSection.Position = UDim2.new(0, 0, 0, 410)
AdditionalModsSection.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AdditionalModsSection.Parent = MainFrame

local AdditionalModsTitle = Instance.new("TextLabel")
AdditionalModsTitle.Size = UDim2.new(1, 0, 0, 30)
AdditionalModsTitle.Position = UDim2.new(0, 0, 0, 0)
AdditionalModsTitle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
AdditionalModsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
AdditionalModsTitle.Text = "Additional Mods"
AdditionalModsTitle.TextScaled = true
AdditionalModsTitle.Parent = AdditionalModsSection

-- Mod 1: Infinite Yield
local InfiniteYieldToggle = Instance.new("TextButton")
InfiniteYieldToggle.Size = UDim2.new(1, 0, 0, 30)
InfiniteYieldToggle.Position = UDim2.new(0, 0, 0, 30)
InfiniteYieldToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfiniteYieldToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteYieldToggle.Text = "Infinite Yield"
InfiniteYieldToggle.Parent = AdditionalModsSection

local isInfiniteYieldEnabled = false

InfiniteYieldToggle.MouseButton1Click:Connect(function()
    isInfiniteYieldEnabled = not isInfiniteYieldEnabled
    if isInfiniteYieldEnabled then
        InfiniteYieldToggle.Text = "Infinite Yield (On)"
        -- Implement Infinite Yield functionality
    else
        InfiniteYieldToggle.Text = "Infinite Yield (Off)"
    end
end)

-- Mod 2: God Mode
local GodModeToggle = Instance.new("TextButton")
GodModeToggle.Size = UDim2.new(1, 0, 0, 30)
GodModeToggle.Position = UDim2.new(0, 0, 0, 60)
GodModeToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
GodModeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
GodModeToggle.Text = "God Mode"
GodModeToggle.Parent = AdditionalModsSection

local isGodModeEnabled = false

GodModeToggle.MouseButton1Click:Connect(function()
    isGodModeEnabled = not isGodModeEnabled
    if isGodModeEnabled then
        GodModeToggle.Text = "God Mode (On)"
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        Humanoid.Health = math.huge
        Humanoid.MaxHealth = math.huge
    else
        GodModeToggle.Text = "God Mode (Off)"
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        Humanoid.Health = 100
        Humanoid.MaxHealth = 100
    end
end)

-- Mod 3: Noclip Walk
local NoclipWalkToggle = Instance.new("TextButton")
NoclipWalkToggle.Size = UDim2.new(1, 0, 0, 30)
NoclipWalkToggle.Position = UDim2.new(0, 0, 0, 90)
NoclipWalkToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
NoclipWalkToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipWalkToggle.Text = "Noclip Walk"
NoclipWalkToggle.Parent = AdditionalModsSection

local isNoclipWalkEnabled = false

NoclipWalkToggle.MouseButton1Click:Connect(function()
    isNoclipWalkEnabled = not isNoclipWalkEnabled
    if isNoclipWalkEnabled then
        NoclipWalkToggle.Text = "Noclip Walk (On)"
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        Humanoid.PlatformStand = true
    else
        NoclipWalkToggle.Text = "Noclip Walk (Off)"
        local Player = game.Players.LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Humanoid = Character:WaitForChild("Humanoid")
        Humanoid.PlatformStand = false
    end
end)

-- Mod 4: Fast Swing
local FastSwingToggle = Instance.new("TextButton")
FastSwingToggle.Size = UDim2.new(1, 0, 0, 30)
FastSwingToggle.Position = UDim2.new(0, 0, 0, 120)
FastSwingToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
FastSwingToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FastSwingToggle.Text = "Fast Swing"
FastSwingToggle.Parent = AdditionalModsSection

local isFastSwingEnabled = false

FastSwingToggle.MouseButton1Click:Connect(function()
    isFastSwingEnabled = not isFastSwingEnabled
    if isFastSwingEnabled then
        FastSwingToggle.Text = "Fast Swing (On)"
        -- Implement Fast Swing functionality
    else
        FastSwingToggle.Text = "Fast Swing (Off)"
    end
end)

-- Mod 5: Infinite Stamina
local InfiniteStaminaToggle = Instance.new("TextButton")
InfiniteStaminaToggle.Size = UDim2.new(1, 0, 0, 30)
InfiniteStaminaToggle.Position = UDim2.new(0, 0, 0, 150)
InfiniteStaminaToggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InfiniteStaminaToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfiniteStaminaToggle.Text = "Infinite Stamina"
InfiniteStaminaToggle.Parent = AdditionalModsSection

local isInfiniteStamina
