-- Tux's FREE Menu
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Tux's FREE Menu",
   LoadingTitle = "Loading Tux's Menu...",
   LoadingSubtitle = "by Tux",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "TuxMenu",
      FileName = "TuxConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "4F7rMQtGhe",
      RememberJoins = true
   },
   KeySystem = false
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- Variables
local flyEnabled = false
local noclipEnabled = false
local espEnabled = false
local aimbotEnabled = false
local speedhackEnabled = false
local infiniteJumpEnabled = false
local godmodeEnabled = false
local fullbrightEnabled = false
local clickTpEnabled = false

local flySpeed = 50
local walkSpeed = 16
local jumpHeight = 50
local aimbotFOV = 200
local aimbotSmoothness = 1

-- Connections
local flyConnection
local noclipConnection
local espConnection
local aimbotConnection
local speedConnection
local infiniteJumpConnection

-- Objects
local flyBodyVelocity
local flyBodyAngularVelocity
local originalLighting = {}

-- FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Transparency = 0.5
FOVCircle.NumSides = 100
FOVCircle.Filled = false

-- Movement Tab
local MovementTab = Window:CreateTab("Movement", 4483362458)

-- Fly Toggle
local FlyToggle = MovementTab:CreateToggle({
   Name = "Fly",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      flyEnabled = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      local rootPart = character and character:FindFirstChild("HumanoidRootPart")
      
      if flyEnabled then
         if character and humanoid and rootPart then
            -- Create BodyVelocity
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.Parent = rootPart
            
            -- Create BodyAngularVelocity
            flyBodyAngularVelocity = Instance.new("BodyAngularVelocity")
            flyBodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            flyBodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            flyBodyAngularVelocity.Parent = rootPart
            
            -- Fly loop
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
            
            Rayfield:Notify({
               Title = "Fly Enabled",
               Content = "Use WASD to move, Space/Shift for up/down",
               Duration = 3,
               Image = 4483362458
            })
         end
      else
         -- Disable fly
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
   end,
})

-- Fly Speed Slider
local FlySpeedSlider = MovementTab:CreateSlider({
   Name = "Fly Speed",
   Range = {1, 200},
   Increment = 1,
   CurrentValue = flySpeed,
   Flag = "FlySpeed",
   Callback = function(Value)
      flySpeed = Value
   end,
})

-- NoClip Toggle
local NoClipToggle = MovementTab:CreateToggle({
   Name = "NoClip",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
      noclipEnabled = Value
      
      if noclipEnabled then
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
         
         Rayfield:Notify({
            Title = "NoClip Enabled",
            Content = "You can now walk through walls",
            Duration = 3,
            Image = 4483362458
         })
      else
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
   end,
})

-- Speed Hack Toggle
local SpeedToggle = MovementTab:CreateToggle({
   Name = "Speed Hack",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
      speedhackEnabled = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      
      if speedhackEnabled and humanoid then
         humanoid.WalkSpeed = walkSpeed
         speedConnection = humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
            if speedhackEnabled then
               humanoid.WalkSpeed = walkSpeed
            end
         end)
      else
         if speedConnection then
            speedConnection:Disconnect()
            speedConnection = nil
         end
         if humanoid then
            humanoid.WalkSpeed = 16
         end
      end
   end,
})

-- Speed Slider
local SpeedSlider = MovementTab:CreateSlider({
   Name = "Walk Speed",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = walkSpeed,
   Flag = "WalkSpeed",
   Callback = function(Value)
      walkSpeed = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if speedhackEnabled and humanoid then
         humanoid.WalkSpeed = walkSpeed
      end
   end,
})

-- Jump Height Slider
local JumpSlider = MovementTab:CreateSlider({
   Name = "Jump Height",
   Range = {50, 500},
   Increment = 1,
   CurrentValue = jumpHeight,
   Flag = "JumpHeight",
   Callback = function(Value)
      jumpHeight = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.JumpPower = jumpHeight
      end
   end,
})

-- Infinite Jump Toggle
local InfiniteJumpToggle = MovementTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(Value)
      infiniteJumpEnabled = Value
      
      if infiniteJumpEnabled then
         infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            if infiniteJumpEnabled then
               local character = LocalPlayer.Character
               local humanoid = character and character:FindFirstChildOfClass("Humanoid")
               if humanoid then
                  humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
               end
            end
         end)
      else
         if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
         end
      end
   end,
})

-- Combat Tab
local CombatTab = Window:CreateTab("Combat", 4483362458)

-- Aimbot functions
local function getClosestPlayerInFOV()
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
local AimbotToggle = CombatTab:CreateToggle({
   Name = "Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      aimbotEnabled = Value
      
      if aimbotEnabled then
         FOVCircle.Visible = true
         
         aimbotConnection = RunService.RenderStepped:Connect(function()
            if aimbotEnabled then
               local mouseLocation = UserInputService:GetMouseLocation()
               FOVCircle.Position = mouseLocation
               FOVCircle.Radius = aimbotFOV
               
               local closestPlayer = getClosestPlayerInFOV()
               if closestPlayer and closestPlayer.Character and closestPlayer.Character:FindFirstChild("Head") then
                  local head = closestPlayer.Character.Head
                  local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, head.Position)
                  Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, aimbotSmoothness * 0.1)
               end
            end
         end)
         
         Rayfield:Notify({
            Title = "Aimbot Enabled",
            Content = "FOV circle is now visible",
            Duration = 3,
            Image = 4483362458
         })
      else
         FOVCircle.Visible = false
         if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
         end
      end
   end,
})

-- Aimbot FOV Slider
local FOVSlider = CombatTab:CreateSlider({
   Name = "Aimbot FOV",
   Range = {50, 500},
   Increment = 5,
   CurrentValue = aimbotFOV,
   Flag = "AimbotFOV",
   Callback = function(Value)
      aimbotFOV = Value
      FOVCircle.Radius = aimbotFOV
   end,
})

-- Aimbot Smoothness Slider
local SmoothnessSlider = CombatTab:CreateSlider({
   Name = "Aimbot Smoothness",
   Range = {1, 10},
   Increment = 1,
   CurrentValue = aimbotSmoothness,
   Flag = "AimbotSmoothness",
   Callback = function(Value)
      aimbotSmoothness = Value
   end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("Visual", 4483362458)

-- ESP Toggle
local ESPToggle = VisualTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      espEnabled = Value
      
      if espEnabled then
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
               local highlight = Instance.new("Highlight")
               highlight.Name = "PlayerESP"
               highlight.Adornee = player.Character
               highlight.FillColor = Color3.new(1, 0, 0)
               highlight.OutlineColor = Color3.new(1, 1, 1)
               highlight.FillTransparency = 0.5
               highlight.OutlineTransparency = 0
               highlight.Parent = player.Character
            end
         end
         
         espConnection = Players.PlayerAdded:Connect(function(player)
            if espEnabled then
               player.CharacterAdded:Connect(function(character)
                  wait(1)
                  if espEnabled and character then
                     local highlight = Instance.new("Highlight")
                     highlight.Name = "PlayerESP"
                     highlight.Adornee = character
                     highlight.FillColor = Color3.new(1, 0, 0)
                     highlight.OutlineColor = Color3.new(1, 1, 1)
                     highlight.FillTransparency = 0.5
                     highlight.OutlineTransparency = 0
                     highlight.Parent = character
                  end
               end)
            end
         end)
         
         Rayfield:Notify({
            Title = "ESP Enabled",
            Content = "Players are now highlighted",
            Duration = 3,
            Image = 4483362458
         })
      else
         if espConnection then
            espConnection:Disconnect()
            espConnection = nil
         end
         
         for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
               local highlight = player.Character:FindFirstChild("PlayerESP")
               if highlight then
                  highlight:Destroy()
               end
            end
         end
      end
   end,
})

-- Fullbright Toggle
local FullbrightToggle = VisualTab:CreateToggle({
   Name = "Fullbright",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
      fullbrightEnabled = Value
      
      if fullbrightEnabled then
         originalLighting.Brightness = Lighting.Brightness
         originalLighting.ClockTime = Lighting.ClockTime
         originalLighting.FogEnd = Lighting.FogEnd
         originalLighting.GlobalShadows = Lighting.GlobalShadows
         originalLighting.Ambient = Lighting.Ambient
         
         Lighting.Brightness = 2
         Lighting.ClockTime = 14
         Lighting.FogEnd = 100000
         Lighting.GlobalShadows = false
         Lighting.Ambient = Color3.new(1, 1, 1)
      else
         Lighting.Brightness = originalLighting.Brightness or 1
         Lighting.ClockTime = originalLighting.ClockTime or 14
         Lighting.FogEnd = originalLighting.FogEnd or 100000
         Lighting.GlobalShadows = originalLighting.GlobalShadows or true
         Lighting.Ambient = originalLighting.Ambient or Color3.new(0, 0, 0)
      end
   end,
})

-- Utility Tab
local UtilityTab = Window:CreateTab("Utility", 4483362458)

-- God Mode Toggle
local GodModeToggle = UtilityTab:CreateToggle({
   Name = "God Mode",
   CurrentValue = false,
   Flag = "GodModeToggle",
   Callback = function(Value)
      godmodeEnabled = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      
      if godmodeEnabled and humanoid then
         humanoid.MaxHealth = math.huge
         humanoid.Health = math.huge
         
         Rayfield:Notify({
            Title = "God Mode Enabled",
            Content = "You are now invincible",
            Duration = 3,
            Image = 4483362458
         })
      elseif humanoid then
         humanoid.MaxHealth = 100
         humanoid.Health = 100
      end
   end,
})

-- Click TP Toggle
local ClickTPToggle = UtilityTab:CreateToggle({
   Name = "Click Teleport",
   CurrentValue = false,
   Flag = "ClickTPToggle",
   Callback = function(Value)
      clickTpEnabled = Value
      
      if clickTpEnabled then
         Rayfield:Notify({
            Title = "Click TP Enabled",
            Content = "Hold Ctrl and click to teleport",
            Duration = 3,
            Image = 4483362458
         })
      end
   end,
})

-- Click TP functionality
local Mouse = LocalPlayer:GetMouse()
Mouse.Button1Down:Connect(function()
   if clickTpEnabled and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
      local character = LocalPlayer.Character
      local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
      if humanoidRootPart then
         humanoidRootPart.CFrame = CFrame.new(Mouse.Hit.Position + Vector3.new(0, 5, 0))
      end
   end
end)

-- Load Infinite Yield Button
local InfiniteYieldButton = UtilityTab:CreateButton({
   Name = "Load Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
      Rayfield:Notify({
         Title = "Infinite Yield Loaded",
         Content = "Infinite Yield admin commands loaded",
         Duration = 3,
         Image = 4483362458
      })
   end,
})

-- Character respawn handler
LocalPlayer.CharacterAdded:Connect(function(character)
   wait(1)
   local humanoid = character:WaitForChild("Humanoid", 5)
   if humanoid then
      if speedhackEnabled then
         humanoid.WalkSpeed = walkSpeed
      end
      if jumpHeight ~= 50 then
         humanoid.JumpPower = jumpHeight
      end
      if godmodeEnabled then
         humanoid.MaxHealth = math.huge
         humanoid.Health = math.huge
      end
   end
end)

-- Cleanup function
local function cleanup()
   if flyConnection then flyConnection:Disconnect() end
   if noclipConnection then noclipConnection:Disconnect() end
   if espConnection then espConnection:Disconnect() end
   if aimbotConnection then aimbotConnection:Disconnect() end
   if speedConnection then speedConnection:Disconnect() end
   if infiniteJumpConnection then infiniteJumpConnection:Disconnect() end
   
   if flyBodyVelocity then flyBodyVelocity:Destroy() end
   if flyBodyAngularVelocity then flyBodyAngularVelocity:Destroy() end
   
   FOVCircle.Visible = false
end

-- Final notification
Rayfield:Notify({
   Title = "Tux's Menu Loaded!",
   Content = "All features are ready to use",
   Duration = 5,
   Image = 4483362458
})
