local players = game:GetService("Players")
local runService = game:GetService("RunService")
local lighting = game:GetService("Lighting")
local userInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local collectionService = game:GetService("CollectionService")
local rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local window = rayfield:CreateWindow({
  Name = "SHENRU | MVSD SCRIPT",
  LoadingTitle = "SHENRU",
  LoadingSubtitle = "SHENRU ONLY MVSD!",
  ConfigurationSaving = { Enabled = false },
})

local homeTab = window:CreateTab("HOME", "home")
local visualsTab = window:CreateTab("VISUALS", "eye")
local combatTab = window:CreateTab("COMBAT", "crosshair")
local playerABILITYTab = window:CreateTab("PLAYER ABILITY", "footprints")

local v1 = {
  ChamsAll = false,
  ChamsEnemy = false,
  ChamsTeam = false,
  ChamsColor = Color3.fromRGB(120, 0, 255),
  Fullbright = false,
  NoShadow = false,
  NoFog = false,
  SilentAim = false,
  WallCheck = true,
  HitboxEnabled = false,
  HitboxSize = 10,
  HitboxColor = Color3.fromRGB(255, 0, 0),
  SpeedEnabled = false,
  SpeedValue = 30,
  JumpEnabled = false,
  JumpValue = 50,
  Noclip = false,
  InfJump = false,
  AutoKillAll = false,
}

local localPlayer = players.LocalPlayer
local currentCamera = workspace.CurrentCamera
local v2 = {}
local v3 = false
local v4 = 0

local function f1(p1)
  local humanoid = p1:WaitForChild("Humanoid")

  if v1.SpeedEnabled then
    humanoid.WalkSpeed = v1.SpeedValue
  end

  if v1.JumpEnabled then
    humanoid.UseJumpPower = true
    humanoid.JumpPower = v1.JumpValue
  end
end

localPlayer.CharacterAdded:Connect(f1)

if localPlayer.Character then
  f1(localPlayer.Character)
end

local function f2(p2, p3)
  local callback = p3.Callback

  function p3.Callback(p4)
    if callback then
      callback(p4)
    end

    rayfield:Notify({
      Title = "SHENRU | MVSD",
      Content = p3.Name .. (p4 and " ENABLED" or " DISABLED"),
      Duration = 2,
      Image = "bell",
    })
  end

  p2:CreateToggle(p3)
end

task.spawn(function()
  while task.wait(0.1) do
    pcall(function()
      for key, value in pairs(game.CoreGui:GetDescendants()) do
        if (value:IsA("TextLabel") or value:IsA("TextButton")) and value.Text then
          if string.find(value.Text, "Rayfield") then
            value.Text = string.gsub(value.Text, "Rayfield", "SHEN")
          end
        end
      end
    end)
  end
end)

local function f3(p5)
  local team = p5:GetAttribute("Team")

  if team then
    return team
  elseif p5.Team then
    return p5.Team
  else
    if p5.TeamColor then
      return p5.TeamColor
    end

    return nil
  end
end

local function f4(p6)
  if p6 == localPlayer then
    return false
  else
    local v5 = f3(localPlayer)
    local v6 = f3(p6)

    if v5 and v6 then
      return v5 ~= v6
    end

    return true
  end
end

local function f5(p7, p8)
  if not v1.WallCheck then
    return true
  else
    local position = currentCamera.CFrame.Position

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = { localPlayer.Character, p7, currentCamera }

    for index, value2 in ipairs({
      p8, p7:FindFirstChild("Head"), p7:FindFirstChild("UpperTorso"),
      p7:FindFirstChild("HumanoidRootPart"),
    }) do
      if value2 then
        if not workspace:Raycast(position, value2.Position - position, raycastParams) then
          return true
        end
      end
    end

    return false
  end
end

local function f6(p9)
  return p9 and p9.X == p9.X and p9.Y == p9.Y and p9.Z == p9.Z and math.abs(p9.X) < math.huge
    and math.abs(p9.Y) < math.huge and math.abs(p9.Z) < math.huge
end

local function f7(p10, p11)
  local huge = math.huge
  local position2 = currentCamera.CFrame.Position

  local vector = Vector2.new(
    p10 or currentCamera.ViewportSize.X / 2, p11 or currentCamera.ViewportSize.Y / 2
  )

  local v7, magnitude

  for index2, value3 in ipairs(players:GetPlayers()) do
    if value3 ~= localPlayer and f4(value3) then
      local character = value3.Character

      local humanoid2 = character
      humanoid2 = character and character:FindFirstChildOfClass("Humanoid")

      local humanoidRootPart = character
      humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

      if character and humanoid2 and humanoidRootPart and humanoid2.Health > 0 then
        local upperTorso = character:FindFirstChild("UpperTorso") or humanoidRootPart

        if upperTorso and f5(character, upperTorso) then
          local v8, v9 = currentCamera:WorldToViewportPoint(upperTorso.Position)

          if v9 and v8.Z > 0 then
            magnitude = (Vector2.new(v8.X, v8.Y) - vector).Magnitude
          else
            magnitude = (upperTorso.Position - position2).Magnitude + 100000
          end

          if magnitude < huge then
            huge = magnitude
            v7 = value3
          end
        end
      end
    end
  end

  return v7
end

task.spawn(function()
  pcall(function()
    local v10 = require(replicatedStorage.Modules.WeaponRaycast)
    local convertScreenPointToVector3 = v10.convertScreenPointToVector3

    function v10.convertScreenPointToVector3(p12)
      if v1.SilentAim and not v3 and not checkcaller() then
        local v11 = f7(p12.X, p12.Y)

        if v11 and v11.Character then
          local upperTorso2 = v11.Character:FindFirstChild("UpperTorso")
            or v11.Character:FindFirstChild("HumanoidRootPart")

          if upperTorso2 then
            return upperTorso2.Position
          end
        end

        return convertScreenPointToVector3(p12)
      end

      return convertScreenPointToVector3(p12)
    end
  end)
end)

task.spawn(function()
  pcall(function()
    local waitForChild = replicatedStorage:WaitForChild("Remotes", 10)

    if waitForChild then
      local waitForChild2 = waitForChild:WaitForChild("ShootGun", 10)

      if waitForChild2 then
        hookfunction(waitForChild2.FireServer, function(p13, p14, p15, p16, p17)
          local v12 = p16
          local position3 = p17
          local silentAim = v1.SilentAim
          local position4 = p15

          if silentAim and not v3 then
            local worldToViewportPoint = currentCamera:WorldToViewportPoint(position4
              or Vector3.new(0, 0, 0))

            local v13 = f7(worldToViewportPoint.X, worldToViewportPoint.Y)

            if v13 and v13.Character then
              local upperTorso3 = v13.Character:FindFirstChild("UpperTorso")
                or v13.Character:FindFirstChild("HumanoidRootPart")

              if upperTorso3 then
                v12 = upperTorso3
                position4 = upperTorso3.Position
                position3 = upperTorso3.Position
              end
            end
          end

          if not f6(position4) then
            position4 = currentCamera.CFrame.Position + currentCamera.CFrame.LookVector * 1000
          end

          if not f6(position3) then
            position3 = position4
          end

          return oldShoot(p13, p14, position4, v12, position3)
        end)
      end

      local waitForChild3 = waitForChild:WaitForChild("ThrowHit", 10)

      if waitForChild3 then
        hookfunction(waitForChild3.FireServer, function(p18, p19, p20)
          local v14 = p19
          local position5 = p20

          if v1.SilentAim and not v3 then
            local worldToViewportPoint2 = currentCamera:WorldToViewportPoint(position5
              or Vector3.new(0, 0, 0))

            local v15 = f7(worldToViewportPoint2.X, worldToViewportPoint2.Y)

            if v15 and v15.Character then
              local upperTorso4 = v15.Character:FindFirstChild("UpperTorso")
                or v15.Character:FindFirstChild("HumanoidRootPart")

              if upperTorso4 then
                v14 = upperTorso4
                position5 = upperTorso4.Position
              end
            end
          end

          if not f6(position5) then
            position5 = currentCamera.CFrame.Position + currentCamera.CFrame.LookVector * 1000
          end

          return oldThrow(p18, v14, position5)
        end)
      end
    end
  end)
end)

local function f8()
  local shootGun, humanoid3, v16

  if v3 then
    return
  else
    local remotes = replicatedStorage:FindFirstChild("Remotes")

    if not remotes then
      return
    end

    shootGun = remotes:FindFirstChild("ShootGun")

    if not shootGun then
      return
    else
      local character2 = localPlayer.Character

      if not character2 then
        return
      end

      humanoid3 = character2:FindFirstChildOfClass("Humanoid")

      if not humanoid3 then
        return
      else
        local backpack = localPlayer:FindFirstChild("Backpack")
        v16 = nil

        local function f9(p21)
          if not p21:IsA("Tool") then
            return false
          elseif p21.Name == "Afterdark" then
            return false
          elseif p21.Name == "Colt" then
            return true
          else
            if collectionService:HasTag(p21, "GUN_TOOL") then
              return true
            end

            if p21:FindFirstChild("Muzzle", true) then
              return true
            end

            return false
          end
        end

        if backpack then
          for index3, value4 in ipairs(backpack:GetChildren()) do
            if f9(value4) then
              v16 = value4
              break
            end
          end
        end

        for index4, value5 in ipairs(character2:GetChildren()) do
          if f9(value5) then
            v16 = value5
            break
          end
        end

        if not v16 then
          return
        else
          if v16.Parent == backpack then
            v16.Parent = character2
          end

          pcall(function() humanoid3:EquipTool(v16) end)
          task.wait(0.2)
          v3 = true

          pcall(function() v16.Enabled = true end)
          pcall(function() v16:Activate() end)

          task.wait(0.05)
          local findFirstChild = v16:FindFirstChild("Muzzle", true)

          local worldPosition = findFirstChild and findFirstChild.WorldPosition
            or character2:FindFirstChild("Head") and character2.Head.Position
            or character2:GetPivot().Position

          for index5, value6 in ipairs(players:GetPlayers()) do
            if value6 ~= localPlayer and f4(value6) then
              local character3 = value6.Character

              if character3 then
                character3:FindFirstChild("HumanoidRootPart")
              end

              local upperTorso5 = character3 and character3:FindFirstChild("UpperTorso")

              local humanoid4 = character3
              humanoid4 = character3 and character3:FindFirstChildOfClass("Humanoid")

              if upperTorso5 and humanoid4 and humanoid4.Health > 0 then
                task.spawn(function()
                  if f6(upperTorso5.Position) then
                    pcall(function()
                      shootGun:FireServer(
                        worldPosition, upperTorso5.Position, upperTorso5, upperTorso5.Position
                      )
                    end)
                  end
                end)

                runService.Heartbeat:Wait()
              end
            end
          end

          v3 = false
          return
        end
      end
    end
  end
end

task.spawn(function()
  while task.wait(0.5) do
    if v1.AutoKillAll then
      f8()
    end
  end
end)

userInputService.JumpRequest:Connect(function()
  if v1.InfJump then
    local character4 = localPlayer.Character
    local humanoid5 = character4 and character4:FindFirstChildOfClass("Humanoid")

    if humanoid5 then
      humanoid5:ChangeState("Jumping")
    end
  end
end)

local function f10(p22)
  local character5 = p22.Character

  if not character5 then
    return
  else
    local humanoid6 = character5:FindFirstChildOfClass("Humanoid")

    if not humanoid6 or humanoid6.Health <= 0 then
      local kovakChams = character5:FindFirstChild("KovakChams")

      if kovakChams then
        kovakChams:Destroy()
      end

      return
    else
      local v17 = false
      local v18 = f4(p22)
      local chamsColor = v1.ChamsColor

      if v1.ChamsAll then
        v17 = true
      elseif v1.ChamsEnemy and v18 then
        v17 = true
        chamsColor = Color3.fromRGB(255, 0, 0)
      elseif v1.ChamsTeam and not v18 then
        v17 = true
        chamsColor = Color3.fromRGB(0, 255, 0)
      end

      local kovakChams2 = character5:FindFirstChild("KovakChams")

      if v17 then
        if not kovakChams2 then
          kovakChams2 = Instance.new("Highlight")
          kovakChams2.Name = "KovakChams"
          kovakChams2.FillTransparency = 0.5
          kovakChams2.OutlineTransparency = 0
          kovakChams2.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
          kovakChams2.Adornee = character5
          kovakChams2.Parent = character5
        end

        kovakChams2.Enabled = true
        kovakChams2.FillColor = chamsColor
        kovakChams2.OutlineColor = chamsColor
      elseif kovakChams2 then
        kovakChams2:Destroy()
      end

      return
    end
  end
end

local v19, brightness

local function f11()
  if v1.Fullbright then
    if not brightness then
      brightness = lighting.Brightness
    end

    lighting.Ambient = Color3.fromRGB(255, 255, 255)
    lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    lighting.Brightness = 2
  elseif brightness then
    lighting.Brightness = brightness
  end

  lighting.GlobalShadows = not v1.NoShadow

  if v1.NoFog then
    if not v19 then
      v19 = { lighting.FogEnd, lighting.FogStart, lighting.FogColor }
    end

    lighting.FogEnd = 1000000000
    lighting.FogStart = 1000000000
    lighting.FogColor = Color3.fromRGB(0, 0, 0)
  elseif v19 then
    local fogStart = v19[2]
    local fogColor = v19[3]

    lighting.FogEnd = v19[1]
    lighting.FogStart = fogStart
    lighting.FogColor = fogColor

    v19 = nil
  end
end

runService.Heartbeat:Connect(function(delta)
  pcall(function()
    currentCamera = workspace.CurrentCamera
    v4 = v4 + delta

    if v4 < 0.1 then
      return
    else
      v4 = 0
      local character6 = localPlayer.Character

      if v1.Noclip and character6 then
        for index6, value7 in ipairs(character6:GetDescendants()) do
          if value7:IsA("BasePart") and value7.CanCollide then
            value7.CanCollide = false
          end
        end
      end

      for index7, value8 in ipairs(players:GetPlayers()) do
        if value8 ~= localPlayer then
          local character7 = value8.Character

          local humanoidRootPart2 = character7
          humanoidRootPart2 = character7 and character7:FindFirstChild("HumanoidRootPart")

          local humanoid7 = character7
          humanoid7 = character7 and character7:FindFirstChildOfClass("Humanoid")

          if character7 and humanoidRootPart2 and humanoid7 then
            if v1.HitboxEnabled and f4(value8) and humanoid7.Health > 0 then
              if not v2[humanoidRootPart2] then
                v2[humanoidRootPart2] = {
                  Size = humanoidRootPart2.Size,
                  Transparency = humanoidRootPart2.Transparency,
                  CanCollide = humanoidRootPart2.CanCollide,
                }
              end

              humanoidRootPart2.Size = Vector3.new(v1.HitboxSize, v1.HitboxSize, v1.HitboxSize)
              humanoidRootPart2.Transparency = 1
              humanoidRootPart2.CanCollide = false

              local hitboxVisual = humanoidRootPart2:FindFirstChild("HitboxVisual")

              if not hitboxVisual then
                hitboxVisual = Instance.new("BoxHandleAdornment")
                hitboxVisual.Name = "HitboxVisual"
                hitboxVisual.Adornee = humanoidRootPart2
                hitboxVisual.AlwaysOnTop = true
                hitboxVisual.ZIndex = 5
                hitboxVisual.Parent = humanoidRootPart2
              end

              hitboxVisual.Size = humanoidRootPart2.Size
              hitboxVisual.Color3 = v1.HitboxColor
              hitboxVisual.Transparency = 0.5
              hitboxVisual.Visible = true
            else
              if v2[humanoidRootPart2] then
                humanoidRootPart2.Size = v2[humanoidRootPart2].Size
                humanoidRootPart2.Transparency = v2[humanoidRootPart2].Transparency
                humanoidRootPart2.CanCollide = v2[humanoidRootPart2].CanCollide

                v2[humanoidRootPart2] = nil
              end

              local hitboxVisual2 = humanoidRootPart2:FindFirstChild("HitboxVisual")

              if hitboxVisual2 then
                hitboxVisual2.Visible = false
              end
            end
          end

          f10(value8)
        end
      end

      return
    end
  end)
end)

homeTab:CreateSection("INFO")

homeTab:CreateParagraph({
  Title = "FEATURES:",
  Content = [[
+ KILL ALL
+ SILENT AIM
+ CHAMS (VISUALS)
+ NOCLIP
+ JUMP POWER
+ WALK SPEED
- and more...!]],
})

homeTab:CreateSection("SOCIALS")

homeTab:CreateButton({
  Name = "TELEGRAM CHANNEL",
  Callback = function()
    pcall(function() setclipboard("https://t.me/xinxaoscripts") end)

    rayfield:Notify({
      Title = "SHENRU | LINKS",
      Content = "Telegram Link Copied!",
      Duration = 3,
      Image = "bell",
    })
  end,
})

homeTab:CreateButton({
  Name = "YOUTUBE CHANNEL",
  Callback = function()
    pcall(function() setclipboard("https://youtube.com/@shenonlydev") end)

    rayfield:Notify({
      Title = "SHENRU | LINKS",
      Content = "YouTube Link Copied!",
      Duration = 3,
      Image = "bell",
    })
  end,
})

homeTab:CreateButton({
  Name = "OWNER",
  Callback = function()
    pcall(function() setclipboard("https://t.me/xinjukai") end)

    rayfield:Notify({
      Title = "SHENRU | LINKS",
      Content = "Owner Link Copied!",
      Duration = 3,
      Image = "bell",
    })
  end,
})

visualsTab:CreateSection("Chams")

f2(visualsTab, {
  Name = "CHAMS ALL",
  CurrentValue = false,
  Flag = "ChamsAll",
  Callback = function(value9) v1.ChamsAll = value9 end,
})

f2(visualsTab, {
  Name = "CHAMS ENEMY",
  CurrentValue = false,
  Flag = "ChamsEnemy",
  Callback = function(value10) v1.ChamsEnemy = value10 end,
})

f2(visualsTab, {
  Name = "CHAMS TEAM",
  CurrentValue = false,
  Flag = "ChamsTeam",
  Callback = function(value11) v1.ChamsTeam = value11 end,
})

visualsTab:CreateColorPicker({
  Name = "Chams Color",
  Color = Color3.fromRGB(120, 0, 255),
  Flag = "ChamsColor",
  Callback = function(value12) v1.ChamsColor = value12 end,
})

visualsTab:CreateSection("World")

f2(visualsTab, {
  Name = "Fullbright",
  CurrentValue = false,
  Flag = "Fullbright",
  Callback = function(value13)
    v1.Fullbright = value13
    f11()
  end,
})

f2(visualsTab, {
  Name = "No Shadows",
  CurrentValue = false,
  Flag = "NoShadow",
  Callback = function(value14)
    v1.NoShadow = value14
    f11()
  end,
})

f2(visualsTab, {
  Name = "No Fog",
  CurrentValue = false,
  Flag = "NoFog",
  Callback = function(value15)
    v1.NoFog = value15
    f11()
  end,
})

combatTab:CreateSection("Kill All")

combatTab:CreateButton({
  Name = "KILL ALL ENEMIES",
  Callback = function()
    task.spawn(f8)

    rayfield:Notify({
      Title = "SHENRU | COMBAT",
      Content = "Kill All Fired!",
      Duration = 3,
      Image = "skull",
    })
  end,
})

f2(combatTab, {
  Name = "Auto Kill All",
  CurrentValue = false,
  Flag = "AutoKillAll",
  Callback = function(value16) v1.AutoKillAll = value16 end,
})

combatTab:CreateSection("Silent Aim")

f2(combatTab, {
  Name = "Enable Silent Aim",
  CurrentValue = false,
  Flag = "SilentAim",
  Callback = function(value17) v1.SilentAim = value17 end,
})

f2(combatTab, {
  Name = "Wall Check",
  CurrentValue = true,
  Flag = "WallCheck",
  Callback = function(value18) v1.WallCheck = value18 end,
})

combatTab:CreateSection("Hitbox Expander")

f2(combatTab, {
  Name = "Enable Hitbox",
  CurrentValue = false,
  Flag = "HitboxEnabled",
  Callback = function(value19) v1.HitboxEnabled = value19 end,
})

combatTab:CreateSlider({
  Name = "Hitbox Size",
  Range = { 5, 35 },
  Increment = 1,
  Suffix = " studs",
  CurrentValue = 10,
  Flag = "HitboxSize",
  Callback = function(value20) v1.HitboxSize = value20 end,
})

combatTab:CreateColorPicker({
  Name = "Hitbox Color",
  Color = Color3.fromRGB(255, 0, 0),
  Flag = "HitboxColor",
  Callback = function(value21) v1.HitboxColor = value21 end,
})

playerABILITYTab:CreateSection("Movement")

f2(playerABILITYTab, {
  Name = "Speed",
  CurrentValue = false,
  Flag = "SpeedEnabled",
  Callback = function(value22)
    v1.SpeedEnabled = value22

    local humanoid8 = localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid8 then
      humanoid8.WalkSpeed = value22 and v1.SpeedValue or 30
    end
  end,
})

playerABILITYTab:CreateSlider({
  Name = "Speed Value",
  Range = { 16, 150 },
  Increment = 1,
  Suffix = " spd",
  CurrentValue = 30,
  Flag = "SpeedValue",
  Callback = function(value23)
    v1.SpeedValue = value23

    if v1.SpeedEnabled then
      local humanoid9 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid9 then
        humanoid9.WalkSpeed = value23
      end
    end
  end,
})

f2(playerABILITYTab, {
  Name = "Jump Power",
  CurrentValue = false,
  Flag = "JumpEnabled",
  Callback = function(value24)
    v1.JumpEnabled = value24

    local humanoid10 = localPlayer.Character
      and localPlayer.Character:FindFirstChildOfClass("Humanoid")

    if humanoid10 then
      humanoid10.UseJumpPower = true
      humanoid10.JumpPower = value24 and v1.JumpValue or 50
    end
  end,
})

playerABILITYTab:CreateSlider({
  Name = "Jump Value",
  Range = { 50, 300 },
  Increment = 5,
  Suffix = " jmp",
  CurrentValue = 50,
  Flag = "JumpValue",
  Callback = function(value25)
    v1.JumpValue = value25

    if v1.JumpEnabled then
      local humanoid11 = localPlayer.Character
        and localPlayer.Character:FindFirstChildOfClass("Humanoid")

      if humanoid11 then
        humanoid11.JumpPower = value25
      end
    end
  end,
})

playerABILITYTab:CreateSection("Other")

f2(playerABILITYTab, {
  Name = "Noclip",
  CurrentValue = false,
  Flag = "Noclip",
  Callback = function(value26) v1.Noclip = value26 end,
})

f2(playerABILITYTab, {
  Name = "Infinite Jump",
  CurrentValue = false,
  Flag = "InfJump",
  Callback = function(value27) v1.InfJump = value27 end,
})
