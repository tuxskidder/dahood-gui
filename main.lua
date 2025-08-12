-- Tux's DaHood Menu with Working Aimbot
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "Tux's DaHood Menu",
   LoadingTitle = "Loading Tux's Menu",
   LoadingSubtitle = "by Tux",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "TuxDaHoodConfig"
   },
   Discord = {
      Enabled = true,
      Invite = "4F7rMQtGhe",
      RememberJoins = true
   },
   KeySystem = false,
   KeySettings = {
      Title = "Tux's Menu",
      Subtitle = "Key System",
      Note = "No key needed for this script!",
      FileName = "TuxKey",
      SaveKey = false,
      GrabKeyFromSite = false,
      Key = {""}
   }
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Variables
local aimbotEnabled = false
local aimbotKey = Enum.KeyCode.E
local aimbotFOV = 200
local aimbotSmoothness = 0.5
local aimbotVisibleCheck = false
local aimbotTeamCheck = false
local aimbotWallCheck = false
local aimbotTargetPart = "Head"

local espEnabled = false
local flyEnabled = false
local noclipEnabled = false
local speedEnabled = false
local jumpEnabled = false
local godmodeEnabled = false

-- Aimbot Variables
local targetPlayer = nil
local isAiming = false
local currentTarget = nil

-- Connections
local aimbotConnection
local aimbotKeyConnection
local espConnection
local flyConnection
local noclipConnection
local speedConnection

-- Objects
local flyBodyVelocity
local flyBodyAngularVelocity
local espObjects = {}

-- FOV Circle for Aimbot
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.new(1, 1, 1)
FOVCircle.Thickness = 2
FOVCircle.NumSides = 100
FOVCircle.Radius = aimbotFOV
FOVCircle.Transparency = 0.7
FOVCircle.Visible = false
FOVCircle.Filled = false

-- Target Circle
local TargetCircle = Drawing.new("Circle")
TargetCircle.Color = Color3.new(1, 0, 0)
TargetCircle.Thickness = 3
TargetCircle.NumSides = 100
TargetCircle.Radius = 20
TargetCircle.Transparency = 1
TargetCircle.Visible = false
TargetCircle.Filled = false

-- Aimbot Functions
local function isPlayerValid(player)
    if not player or player == LocalPlayer then
        return false
    end
    
    if not player.Character then
        return false
    end
    
    if aimbotTeamCheck and player.Team == LocalPlayer.Team then
        return false
    end
    
    return true
end

local function getTargetPart(player)
    if not player.Character then
        return nil
    end
    
    local targetPart = player.Character:FindFirstChild(aimbotTargetPart)
    if not targetPart then
        targetPart = player.Character:FindFirstChild("Head")
    end
    
    return targetPart
end

local function isVisible(targetPart)
    if not aimbotVisibleCheck then
        return true
    end
    
    local character = LocalPlayer.Character
    if not character then
        return false
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return false
    end
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {character}
    
    local raycastResult = Workspace:Raycast(rootPart.Position, (targetPart.Position - rootPart.Position), raycastParams)
    
    if raycastResult then
        local hit = raycastResult.Instance
        return hit:IsDescendantOf(targetPart.Parent)
    end
    
    return true
end

local function getClosestPlayerInFOV()
    local closestPlayer = nil
    local shortestDistance = aimbotFOV
    local camera = Workspace.CurrentCamera
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    
    for _, player in pairs(Players:GetPlayers()) do
        if isPlayerValid(player) then
            local targetPart = getTargetPart(player)
            if targetPart then
                local screenPosition, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                
                if onScreen then
                    local distance = (Vector2.new(screenPosition.X, screenPosition.Y) - screenCenter).Magnitude
                    
                    if distance < shortestDistance then
                        if isVisible(targetPart) then
                            closestPlayer = player
                            shortestDistance = distance
                        end
                    end
                end
            end
        end
    end
    
    return closestPlayer
end

local function aimAtPlayer(player)
    if not player then
        return
    end
    
    local targetPart = getTargetPart(player)
    if not targetPart then
        return
    end
    
    local camera = Workspace.CurrentCamera
    local targetPosition = targetPart.Position
    
    -- Predict target movement for DaHood physics
    local targetVelocity = targetPart.AssemblyLinearVelocity or Vector3.new(0, 0, 0)
    local distance = (targetPosition - camera.CFrame.Position).Magnitude
    local timeToTarget = distance / 1000 -- Bullet travel time estimation
    local predictedPosition = targetPosition + (targetVelocity * timeToTarget)
    
    -- Calculate aim position with smoothness
    local targetCFrame = CFrame.lookAt(camera.CFrame.Position, predictedPosition)
    local smoothedCFrame = camera.CFrame:Lerp(targetCFrame, aimbotSmoothness)
    
    camera.CFrame = smoothedCFrame
end

-- Combat Tab
local CombatTab = Window:CreateTab("Combat", 4483362458)

local AimbotSection = CombatTab:CreateSection("Aimbot")

local AimbotToggle = CombatTab:CreateToggle({
   Name = "Enable Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      aimbotEnabled = Value
      
      if aimbotEnabled then
         FOVCircle.Visible = true
         
         -- Main aimbot loop
         aimbotConnection = RunService.Heartbeat:Connect(function()
            if aimbotEnabled then
               local camera = Workspace.CurrentCamera
               local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
               FOVCircle.Position = screenCenter
               FOVCircle.Radius = aimbotFOV
               
               if isAiming then
                  if currentTarget and isPlayerValid(currentTarget) then
                     local targetPart = getTargetPart(currentTarget)
                     if targetPart and isVisible(targetPart) then
                        local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
                        if onScreen then
                           local distance = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                           if distance <= aimbotFOV then
                              aimAtPlayer(currentTarget)
                              
                              -- Show target indicator
                              TargetCircle.Position = Vector2.new(screenPos.X, screenPos.Y)
                              TargetCircle.Visible = true
                           else
                              currentTarget = nil
                              isAiming = false
                              TargetCircle.Visible = false
                           end
                        else
                           currentTarget = nil
                           isAiming = false
                           TargetCircle.Visible = false
                        end
                     else
                        currentTarget = nil
                        isAiming = false
                        TargetCircle.Visible = false
                     end
                  else
                     currentTarget = nil
                     isAiming = false
                     TargetCircle.Visible = false
                  end
               end
            end
         end)
         
         -- Aimbot key handler
         aimbotKeyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == aimbotKey and aimbotEnabled then
               if not isAiming then
                  currentTarget = getClosestPlayerInFOV()
                  if currentTarget then
                     isAiming = true
                  end
               end
            end
         end)
         
         -- Stop aiming when key released
         UserInputService.InputEnded:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            
            if input.KeyCode == aimbotKey then
               isAiming = false
               currentTarget = nil
               TargetCircle.Visible = false
            end
         end)
         
         Rayfield:Notify({
            Title = "Aimbot Enabled",
            Content = "Hold " .. aimbotKey.Name .. " to aim at closest player",
            Duration = 6.5,
            Image = 4483362458,
            Actions = {
               Ignore = {
                  Name = "Okay!",
                  Callback = function()
                  end
               },
            },
         })
      else
         FOVCircle.Visible = false
         TargetCircle.Visible = false
         isAiming = false
         currentTarget = nil
         
         if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
         end
         
         if aimbotKeyConnection then
            aimbotKeyConnection:Disconnect()
            aimbotKeyConnection = nil
         end
      end
   end,
})

local FOVSlider = CombatTab:CreateSlider({
   Name = "Aimbot FOV",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = aimbotFOV,
   Flag = "AimbotFOV",
   Callback = function(Value)
      aimbotFOV = Value
      FOVCircle.Radius = Value
   end,
})

local SmoothnessSlider = CombatTab:CreateSlider({
   Name = "Aimbot Smoothness",
   Range = {0.1, 1},
   Increment = 0.05,
   CurrentValue = aimbotSmoothness,
   Flag = "AimbotSmoothness",
   Callback = function(Value)
      aimbotSmoothness = Value
   end,
})

local AimbotKeyDropdown = CombatTab:CreateDropdown({
   Name = "Aimbot Key",
   Options = {"E", "Q", "F", "C", "X", "Z", "Mouse2"},
   CurrentOption = {"E"},
   MultipleOptions = false,
   Flag = "AimbotKey",
   Callback = function(Option)
      local keyMap = {
         ["E"] = Enum.KeyCode.E,
         ["Q"] = Enum.KeyCode.Q,
         ["F"] = Enum.KeyCode.F,
         ["C"] = Enum.KeyCode.C,
         ["X"] = Enum.KeyCode.X,
         ["Z"] = Enum.KeyCode.Z,
         ["Mouse2"] = Enum.UserInputType.MouseButton2
      }
      aimbotKey = keyMap[Option[1]] or Enum.KeyCode.E
   end,
})

local TargetPartDropdown = CombatTab:CreateDropdown({
   Name = "Target Body Part",
   Options = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
   CurrentOption = {"Head"},
   MultipleOptions = false,
   Flag = "TargetPart",
   Callback = function(Option)
      aimbotTargetPart = Option[1]
   end,
})

local VisibleCheckToggle = CombatTab:CreateToggle({
   Name = "Visible Check",
   CurrentValue = false,
   Flag = "VisibleCheck",
   Callback = function(Value)
      aimbotVisibleCheck = Value
   end,
})

local TeamCheckToggle = CombatTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = false,
   Flag = "TeamCheck",
   Callback = function(Value)
      aimbotTeamCheck = Value
   end,
})

-- Visual Tab
local VisualTab = Window:CreateTab("Visual", 4483362458)

local ESPSection = VisualTab:CreateSection("ESP")

local ESPToggle = VisualTab:CreateToggle({
   Name = "Player ESP",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      espEnabled = Value
      
      if espEnabled then
         -- Create ESP for existing players
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
               local highlight = Instance.new("Highlight")
               highlight.Name = "PlayerESP"
               highlight.Adornee = player.Character
               highlight.FillColor = Color3.fromRGB(255, 0, 0)
               highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
               highlight.FillTransparency = 0.5
               highlight.OutlineTransparency = 0
               highlight.Parent = player.Character
               espObjects[player] = highlight
            end
         end
         
         -- Handle new players
         espConnection = Players.PlayerAdded:Connect(function(player)
            if espEnabled then
               player.CharacterAdded:Connect(function(character)
                  wait(1)
                  if espEnabled and character then
                     local highlight = Instance.new("Highlight")
                     highlight.Name = "PlayerESP"
                     highlight.Adornee = character
                     highlight.FillColor = Color3.fromRGB(255, 0, 0)
                     highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                     highlight.FillTransparency = 0.5
                     highlight.OutlineTransparency = 0
                     highlight.Parent = character
                     espObjects[player] = highlight
                  end
               end)
            end
         end)
         
         Rayfield:Notify({
            Title = "ESP Enabled",
            Content = "All players are now highlighted",
            Duration = 6.5,
            Image = 4483362458,
            Actions = {
               Ignore = {
                  Name = "Okay!",
                  Callback = function()
                  end
               },
            },
         })
      else
         -- Remove all ESP
         for player, highlight in pairs(espObjects) do
            if highlight then
               highlight:Destroy()
            end
         end
         espObjects = {}
         
         if espConnection then
            espConnection:Disconnect()
            espConnection = nil
         end
         
         -- Clean up any remaining ESP
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

-- Movement Tab
local MovementTab = Window:CreateTab("Movement", 4483362458)

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
            flyBodyVelocity = Instance.new("BodyVelocity")
            flyBodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            flyBodyVelocity.Parent = rootPart
            
            flyBodyAngularVelocity = Instance.new("BodyAngularVelocity")
            flyBodyAngularVelocity.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            flyBodyAngularVelocity.AngularVelocity = Vector3.new(0, 0, 0)
            flyBodyAngularVelocity.Parent = rootPart
            
            flyConnection = RunService.Heartbeat:Connect(function()
               if flyBodyVelocity and flyBodyVelocity.Parent then
                  local moveVector = Vector3.new(0, 0, 0)
                  local camera = Workspace.CurrentCamera
                  local flySpeed = 50
                  
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
         end
      else
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

-- Misc Tab
local MiscTab = Window:CreateTab("Misc", 4483362458)

local InfiniteYieldButton = MiscTab:CreateButton({
   Name = "Load Infinite Yield",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
      Rayfield:Notify({
         Title = "Infinite Yield Loaded",
         Content = "Admin commands are now available",
         Duration = 6.5,
         Image = 4483362458,
         Actions = {
            Ignore = {
               Name = "Okay!",
               Callback = function()
               end
            },
         },
      })
   end,
})

local DiscordButton = MiscTab:CreateButton({
   Name = "Copy Discord Link",
   Callback = function()
      setclipboard("https://discord.gg/4F7rMQtGhe")
      Rayfield:Notify({
         Title = "Discord Link Copied",
         Content = "discord.gg/4F7rMQtGhe has been copied to clipboard",
         Duration = 6.5,
         Image = 4483362458,
         Actions = {
            Ignore = {
               Name = "Okay!",
               Callback = function()
               end
            },
         },
      })
   end,
})

-- Character respawn handler
LocalPlayer.CharacterAdded:Connect(function()
   wait(2)
   
   -- Re-enable features that should persist
   if espEnabled then
      wait(1)
      local character = LocalPlayer.Character
      if character then
         -- Re-create ESP for all players
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
               local highlight = Instance.new("Highlight")
               highlight.Name = "PlayerESP"
               highlight.Adornee = player.Character
               highlight.FillColor = Color3.fromRGB(255, 0, 0)
               highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
               highlight.FillTransparency = 0.5
               highlight.OutlineTransparency = 0
               highlight.Parent = player.Character
               espObjects[player] = highlight
            end
         end
      end
   end
end)

-- Initial notification
Rayfield:Notify({
   Title = "Tux's DaHood Menu Loaded!",
   Content = "All features are ready. Aimbot key: " .. aimbotKey.Name,
   Duration = 6.5,
   Image = 4483362458,
   Actions = {
      Ignore = {
         Name = "Let's go!",
         Callback = function()
         end
      },
   },
})
