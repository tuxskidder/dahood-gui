-- Tux's FREE Menu
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TuxsFixedMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 650)
MainFrame.Position = UDim2.new(0, 10, 0.5, -325)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(128, 0, 128)
MainFrame.Parent = ScreenGui

-- Make frame draggable
local dragging = false
local dragStart = nil
local startPos = nil

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.BorderSizePixel = 0
Title.Text = "TUX'S FIXED MENU"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- ScrollingFrame for buttons
local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Name = "ScrollFrame"
ScrollFrame.Size = UDim2.new(1, 0, 1, -40)
ScrollFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.BorderSizePixel = 0
ScrollFrame.ScrollBarThickness = 8
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1000)
ScrollFrame.Parent = MainFrame

-- Variables
local buttonYPos = 5
local rgbEnabled = false
local rgbConnection = nil

-- State variables
local flyEnabled = false
local noclipEnabled = false
local espEnabled = false
local aimbotEnabled = false
local godmodeEnabled = false
local speedhackEnabled = false

local flyBodyVelocity = nil
local flyBodyAngularVelocity = nil
local flyConnection = nil
local noclipConnection = nil
local espConnections = {}
local aimbotConnection = nil

local walkSpeed = 16
local jumpPower = 50
local flySpeed = 50
local aimbotFOV = 200

-- Create FOV Circle for aimbot
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 0.7
FOVCircle.NumSides = 64
FOVCircle.Filled = false

-- Button creation function
local function createButton(text, callback)
    local button = Instance.new("TextButton")
    button.Name = text .. "Button"
    button.Size = UDim2.new(1, -10, 0, 35)
    button.Position = UDim2.new(0, 5, 0, buttonYPos)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 1
    button.BorderColor3 = Color3.fromRGB(100, 100, 100)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextScaled = true
    button.Font = Enum.Font.SourceSans
    button.Parent = ScrollFrame
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    end)
    
    button.MouseLeave:Connect(function()
        if not button:GetAttribute("Active") then
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)
    
    button.MouseButton1Click:Connect(callback)
    
    buttonYPos = buttonYPos + 40
    return button
end

-- RGB Animation function
local function updateRGB()
    if rgbEnabled then
        local time = tick() * 3
        local r = math.floor(math.sin(time) * 127 + 128)
        local g = math.floor(math.sin(time + 2.094) * 127 + 128)
        local b = math.floor(math.sin(time + 4.188) * 127 + 128)
        MainFrame.BorderColor3 = Color3.fromRGB(r, g, b)
    end
end

-- RGB Toggle
local rgbButton = createButton("RGB Mode: OFF", function()
    rgbEnabled = not rgbEnabled
    if rgbEnabled then
        rgbButton.Text = "RGB Mode: ON"
        rgbButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        rgbButton:SetAttribute("Active", true)
        if rgbConnection then rgbConnection:Disconnect() end
        rgbConnection = RunService.Heartbeat:Connect(updateRGB)
    else
        rgbButton.Text = "RGB Mode: OFF"
        rgbButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        rgbButton:SetAttribute("Active", false)
        if rgbConnection then rgbConnection:Disconnect() end
        MainFrame.BorderColor3 = Color3.fromRGB(128, 0, 128)
    end
end)

-- Fly Toggle
local flyButton = createButton("Fly: OFF", function()
    flyEnabled = not flyEnabled
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if not character or not humanoid or not rootPart then return end
    
    if flyEnabled then
        flyButton.Text = "Fly: ON"
        flyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        flyButton:SetAttribute("Active", true)
        
        -- Create BodyVelocity
        flyBodyVelocity = Instance.new("BodyVelocity")
        flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
        flyBodyVelocity.Parent = rootPart
        
        -- Create BodyAngularVelocity for stability
        flyBodyAngularVelocity = Instance.new("BodyAngularVelocity")
        flyBodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        flyBodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
        flyBodyAngularVelocity.Parent = rootPart
        
        -- Fly controls
        flyConnection = RunService.Heartbeat:Connect(function()
            if flyBodyVelocity and flyBodyVelocity.Parent then
                local moveVector = Vector3.new(0, 0, 0)
                local camera = Workspace.CurrentCamera
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveVector = moveVector + (camera.CFrame.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveVector = moveVector - (camera.CFrame.LookVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveVector = moveVector - (camera.CFrame.RightVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveVector = moveVector + (camera.CFrame.RightVector * flySpeed)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveVector = moveVector + Vector3.new(0, flySpeed, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveVector = moveVector - Vector3.new(0, flySpeed, 0)
                end
                
                flyBodyVelocity.Velocity = moveVector
            end
        end)
    else
        flyButton.Text = "Fly: OFF"
        flyButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        flyButton:SetAttribute("Active", false)
        
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
        if flyBodyAngularVelocity then
            flyBodyAngularVelocity:Destroy()
            flyBodyAngularVelocity = nil
        end
    end
end)

-- NoClip Toggle
local noclipButton = createButton("NoClip: OFF", function()
    noclipEnabled = not noclipEnabled
    
    if noclipEnabled then
        noclipButton.Text = "NoClip: ON"
        noclipButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        noclipButton:SetAttribute("Active", true)
        
        noclipConnection = RunService.Stepped:Connect(function()
            local character = LocalPlayer.Character
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        noclipButton.Text = "NoClip: OFF"
        noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        noclipButton:SetAttribute("Active", false)
        
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        
        local character = LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Speed Toggle
local speedButton = createButton("Speed: " .. walkSpeed, function()
    walkSpeed = walkSpeed + 10
    if walkSpeed > 100 then walkSpeed = 16 end
    
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = walkSpeed
    end
    
    speedButton.Text = "Speed: " .. walkSpeed
end)

-- Jump Toggle
local jumpButton = createButton("Jump: " .. jumpPower, function()
    jumpPower = jumpPower + 20
    if jumpPower > 150 then jumpPower = 50 end
    
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = jumpPower
    end
    
    jumpButton.Text = "Jump: " .. jumpPower
end)

-- ESP Toggle
local espButton = createButton("ESP: OFF", function()
    espEnabled = not espEnabled
    
    if espEnabled then
        espButton.Text = "ESP: ON"
        espButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        espButton:SetAttribute("Active", true)
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = "ESPHighlight"
                highlight.Adornee = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = player.Character
            end
        end
        
        espConnections[#espConnections + 1] = Players.PlayerAdded:Connect(function(player)
            if espEnabled then
                player.CharacterAdded:Connect(function(character)
                    wait(1)
                    if espEnabled and character then
                        local highlight = Instance.new("Highlight")
                        highlight.Name = "ESPHighlight"
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
        espButton.Text = "ESP: OFF"
        espButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        espButton:SetAttribute("Active", false)
        
        for _, connection in pairs(espConnections) do
            connection:Disconnect()
        end
        espConnections = {}
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("ESPHighlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- Aimbot functions
local function getClosestPlayerToCursor()
    local closestPlayer = nil
    local shortestDistance = aimbotFOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
            local head = player.Character.Head
            local screenPoint, onScreen = Camera:WorldToViewportPoint(head.Position)
            
            if onScreen then
                local mouseLocation = UserInputService:GetMouseLocation()
                local distance = (Vector2.new(screenPoint.X, screenPoint.Y) - mouseLocation).Magnitude
                
                if distance < shortestDistance then
                    closestPlayer = player
                    shortestDistance = distance
                end
            end
        end
    end
    
    return closestPlayer
end

-- Aimbot Toggle
local aimbotButton = createButton("Aimbot: OFF", function()
    aimbotEnabled = not aimbotEnabled
    
    if aimbotEnabled then
        aimbotButton.Text = "Aimbot: ON"
        aimbotButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        aimbotButton:SetAttribute("Active", true)
        FOVCircle.Visible = true
        
        aimbotConnection = RunService.RenderStepped:Connect(function()
            if aimbotEnabled then
                local mouseLocation = UserInputService:GetMouseLocation()
                FOVCircle.Position = mouseLocation
                FOVCircle.Radius = aimbotFOV
                
                local closestPlayer = getClosestPlayerToCursor()
                if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                    local head = closestPlayer.Character.Head
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                end
            end
        end)
    else
        aimbotButton.Text = "Aimbot: OFF"
        aimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        aimbotButton:SetAttribute("Active", false)
        FOVCircle.Visible = false
        
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
    end
end)

-- Aimbot FOV Toggle
local fovButton = createButton("FOV: " .. aimbotFOV, function()
    aimbotFOV = aimbotFOV + 50
    if aimbotFOV > 500 then aimbotFOV = 100 end
    
    fovButton.Text = "FOV: " .. aimbotFOV
    FOVCircle.Radius = aimbotFOV
end)

-- God Mode Toggle
local godButton = createButton("God Mode: OFF", function()
    godmodeEnabled = not godmodeEnabled
    local character = LocalPlayer.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if not humanoid then return end
    
    if godmodeEnabled then
        godButton.Text = "God Mode: ON"
        godButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        godButton:SetAttribute("Active", true)
        
        humanoid.MaxHealth = math.huge
        humanoid.Health = math.huge
    else
        godButton.Text = "God Mode: OFF"
        godButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        godButton:SetAttribute("Active", false)
        
        humanoid.MaxHealth = 100
        humanoid.Health = 100
    end
end)

-- Discord Button
local discordButton = createButton("Copy Discord Link", function()
    setclipboard("https://discord.gg/4F7rMQtGhe")
    StarterGui:SetCore("SendNotification", {
        Title = "Discord Link Copied!",
        Text = "Pasted to clipboard: discord.gg/4F7rMQtGhe",
        Duration = 3
    })
end)

-- Infinite Yield Button
local iyButton = createButton("Load Infinite Yield", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

-- Cleanup function
local function cleanup()
    if rgbConnection then rgbConnection:Disconnect() end
    if flyConnection then flyConnection:Disconnect() end
    if noclipConnection then noclipConnection:Disconnect() end
    if aimbotConnection then aimbotConnection:Disconnect() end
    for _, connection in pairs(espConnections) do
        connection:Disconnect()
    end
    if flyBodyVelocity then flyBodyVelocity:Destroy() end
    if flyBodyAngularVelocity then flyBodyAngularVelocity:Destroy() end
    FOVCircle.Visible = false
end

-- Reset states on character spawn
LocalPlayer.CharacterAdded:Connect(function()
    wait(1)
    -- Reset speed and jump
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = walkSpeed
        humanoid.JumpPower = jumpPower
        if godmodeEnabled then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end
end)

-- Cleanup on script end
game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player == LocalPlayer then
        cleanup()
    end
end)

print("Tux's Fixed Menu loaded successfully!")
