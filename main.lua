-- Tux's Enhanced Keyless Menu GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuxsKeylessMenu"
ScreenGui.Parent = game:GetService("CoreGui")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 220, 0, 600)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Parent = ScreenGui

-- RGB Animation for Main Frame
local rgbEnabled = false
local rgbConnection

local function startRGB()
    if rgbConnection then rgbConnection:Disconnect() end
    rgbConnection = RunService.Heartbeat:Connect(function()
        if rgbEnabled then
            local time = tick() * 2
            local r = math.sin(time) * 127 + 128
            local g = math.sin(time + 2) * 127 + 128
            local b = math.sin(time + 4) * 127 + 128
            MainFrame.BackgroundColor3 = Color3.fromRGB(r, g, b)
            MainFrame.BorderColor3 = Color3.fromRGB(255 - r, 255 - g, 255 - b)
        end
    end)
end

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Tux's Enhanced Menu"
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Scroll Frame for buttons
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollFrame.Position = UDim2.new(0, 0, 0, 50)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 10
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ScrollFrame.Parent = MainFrame

-- Button Creation Function
local function createButton(name, position, clickFunction)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Position = UDim2.new(0, 5, 0, position)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.Font = Enum.Font.Gotham
    button.TextScaled = true
    button.BorderSizePixel = 1
    button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    button.Parent = ScrollFrame
    
    -- Button hover effect
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    button.MouseButton1Click:Connect(clickFunction)
    return button
end

-- Variables
local isFlying = false
local isNoClipping = false
local isESPEnabled = false
local isAimbotEnabled = false
local aimbotFOV = 200
local isGodModeEnabled = false
local speedwalkValue = 16
local jumpboostValue = 50

-- Fly Variables
local flySpeed = 16
local bodyVelocity, bodyAngularVelocity
local flyConnection

-- RGB Toggle
local RGBToggle = createButton("RGB Mode", 10, function()
    rgbEnabled = not rgbEnabled
    if rgbEnabled then
        RGBToggle.Text = "RGB Mode (ON)"
        RGBToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        startRGB()
    else
        RGBToggle.Text = "RGB Mode (OFF)"
        RGBToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        if rgbConnection then rgbConnection:Disconnect() end
        MainFrame.BackgroundColor3 = Color3.fromRGB(128, 0, 128)
        MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    end
end)

-- Enhanced Fly Toggle
local FlyToggle = createButton("Fly", 55, function()
    isFlying = not isFlying
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    if isFlying then
        FlyToggle.Text = "Fly (ON)"
        FlyToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        -- Create BodyVelocity and BodyAngularVelocity
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Parent = rootPart
        
        bodyAngularVelocity = Instance.new("BodyAngularVelocity")
        bodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        bodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bodyAngularVelocity.Parent = rootPart
        
        -- Fly control loop
        flyConnection = RunService.Heartbeat:Connect(function()
            if bodyVelocity and bodyVelocity.Parent then
                local camera = workspace.CurrentCamera
                local moveVector = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - camera.CFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + camera.CFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector - Vector3.new(0, 1, 0)
                end
                
                bodyVelocity.Velocity = moveVector * flySpeed
            end
        end)
    else
        FlyToggle.Text = "Fly (OFF)"
        FlyToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        
        if bodyAngularVelocity then
            bodyAngularVelocity:Destroy()
            bodyAngularVelocity = nil
        end
    end
end)

-- NoClip Toggle
local NoClipToggle = createButton("NoClip", 100, function()
    isNoClipping = not isNoClipping
    local character = LocalPlayer.Character
    if not character then return end
    
    if isNoClipping then
        NoClipToggle.Text = "NoClip (ON)"
        NoClipToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = false
            end
        end
    else
        NoClipToggle.Text = "NoClip (OFF)"
        NoClipToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = true
            end
        end
    end
end)

-- Speedwalk Toggle
local SpeedwalkToggle = createButton("Speedwalk: " .. speedwalkValue, 145, function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    speedwalkValue = speedwalkValue + 4
    if speedwalkValue > 100 then
        speedwalkValue = 16
    end
    
    humanoid.WalkSpeed = speedwalkValue
    SpeedwalkToggle.Text = "Speedwalk: " .. speedwalkValue
end)

-- Jumpboost Toggle
local JumpboostToggle = createButton("Jumpboost: " .. jumpboostValue, 190, function()
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    jumpboostValue = jumpboostValue + 10
    if jumpboostValue > 150 then
        jumpboostValue = 50
    end
    
    humanoid.JumpPower = jumpboostValue
    JumpboostToggle.Text = "Jumpboost: " .. jumpboostValue
end)

-- ESP Toggle
local ESPToggle = createButton("ESP", 235, function()
    isESPEnabled = not isESPEnabled
    
    if isESPEnabled then
        ESPToggle.Text = "ESP (ON)"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local character = player.Character
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                
                if humanoidRootPart then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "ESP_Highlight"
                    highlight.Adornee = character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                    highlight.Parent = character
                end
            end
        end
        
        -- Handle new players joining
        Players.PlayerAdded:Connect(function(player)
            if isESPEnabled then
                player.CharacterAdded:Connect(function(character)
                    wait(1)
                    if isESPEnabled and character then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "ESP_Highlight"
                        highlight.Adornee = character
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
                        highlight.Parent = character
                    end
                end)
            end
        end)
    else
        ESPToggle.Text = "ESP (OFF)"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("ESP_Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- Aimbot FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Thickness = 2
FOVCircle.Transparency = 0.8
FOVCircle.Filled = false
FOVCircle.Radius = aimbotFOV
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Visible = false

-- Aimbot Functions
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local humanoidRootPart = player.Character.HumanoidRootPart
            local vector, onScreen = Camera:WorldToViewportPoint(humanoidRootPart.Position)
            
            if onScreen then
                local mousePos = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(vector.X, vector.Y) - mousePos).Magnitude
                
                if distance < aimbotFOV and distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closestPlayer
end

local aimbotConnection

-- Aimbot Toggle
local AimbotToggle = createButton("Aimbot", 280, function()
    isAimbotEnabled = not isAimbotEnabled
    
    if isAimbotEnabled then
        AimbotToggle.Text = "Aimbot (ON)"
        AimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        FOVCircle.Visible = true
        
        aimbotConnection = RunService.Heartbeat:Connect(function()
            if isAimbotEnabled then
                local closestPlayer = getClosestPlayer()
                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                    local head = closestPlayer.Character.Head
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                end
                
                -- Update FOV circle position
                FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            end
        end)
    else
        AimbotToggle.Text = "Aimbot (OFF)"
        AimbotToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        FOVCircle.Visible = false
        
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
    end
end)

-- Aimbot FOV Adjuster
local FOVToggle = createButton("FOV: " .. aimbotFOV, 325, function()
    aimbotFOV = aimbotFOV + 50
    if aimbotFOV > 500 then
        aimbotFOV = 100
    end
    
    FOVCircle.Radius = aimbotFOV
    FOVToggle.Text = "FOV: " .. aimbotFOV
end)

-- God Mode Toggle
local GodModeToggle = createButton("God Mode", 370, function()
    isGodModeEnabled = not isGodModeEnabled
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if isGodModeEnabled then
        GodModeToggle.Text = "God Mode (ON)"
        GodModeToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    else
        GodModeToggle.Text = "God Mode (OFF)"
        GodModeToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
end)

-- Visit Discord Button
local DiscordButton = createButton("Visit Discord", 415, function()
    setclipboard("https://discord.gg/4F7rMQtGhe")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Discord Link",
        Text = "Link copied to clipboard!",
        Duration = 5
    })
end)

-- Infinite Yield Toggle
local InfiniteYieldToggle = createButton("Infinite Yield", 460, function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- Clean up on character respawn
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    if isESPEnabled then
        ESPToggle.Text = "ESP (OFF)"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        isESPEnabled = false
    end
    
    if isFlying then
        FlyToggle.Text = "Fly (OFF)"
        FlyToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        isFlying = false
        if flyConnection then flyConnection:Disconnect() end
    end
end)

-- Initialize RGB
startRGB()

print("Tux's Sigma Menu Loaded Successfully!")
