local coreGui = game:GetService("CoreGui")
local tweenService = game:GetService("TweenService")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

if coreGui:FindFirstChild("ShenruKeySystem") then
  coreGui.ShenruKeySystem:Destroy()
end

local v1 = ""

pcall(function()
  local httpsPastebinComRawK2C9LnBC = game:HttpGet("https://pastebin.com/raw/K2C9LnBC")

  if httpsPastebinComRawK2C9LnBC and httpsPastebinComRawK2C9LnBC ~= "" then
    v1 = httpsPastebinComRawK2C9LnBC
  end
end)

local shenruKeySystem = Instance.new("ScreenGui")
shenruKeySystem.Name = "ShenruKeySystem"
shenruKeySystem.ResetOnSpawn = false
shenruKeySystem.IgnoreGuiInset = true
shenruKeySystem.Parent = coreGui

local blurEffect = Instance.new("BlurEffect")
blurEffect.Size = 15
blurEffect.Parent = game.Lighting

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 280)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = shenruKeySystem

local uiGradient = Instance.new("UIGradient")

uiGradient.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 15)),
})

uiGradient.Rotation = 45
uiGradient.Parent = mainFrame

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 14)
uiCorner.Parent = mainFrame

local uiStroke = Instance.new("UIStroke")
uiStroke.Color = Color3.fromRGB(100, 100, 100)
uiStroke.Thickness = 1.5
uiStroke.Parent = mainFrame

task.spawn(function()
  while shenruKeySystem.Parent do
    tweenService:Create(
      uiStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
      { Color = Color3.fromRGB(255, 255, 255) }
    ):Play()

    task.wait(1.5)

    tweenService:Create(
      uiStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
      { Color = Color3.fromRGB(80, 80, 80) }
    ):Play()

    task.wait(1.5)
  end
end)

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 20)
title.BackgroundTransparency = 1
title.Text = "SHENRU PROTECTED SYSTEM!"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = mainFrame

local uiGradient2 = Instance.new("UIGradient")

uiGradient2.Color = ColorSequence.new({
  ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
  ColorSequenceKeypoint.new(0.5, Color3.fromRGB(180, 180, 180)),
  ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
})

uiGradient2.Parent = title

local subtitle = Instance.new("TextLabel")
subtitle.Name = "Subtitle"
subtitle.Size = UDim2.new(1, 0, 0, 20)
subtitle.Position = UDim2.new(0, 0, 0, 60)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Developed By XINXAO"
subtitle.TextColor3 = Color3.fromRGB(120, 120, 120)
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 14
subtitle.TextXAlignment = Enum.TextXAlignment.Center
subtitle.Parent = mainFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -45, 0, 15)
closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = mainFrame

local uiCorner2 = Instance.new("UICorner")
uiCorner2.CornerRadius = UDim.new(0, 6)
uiCorner2.Parent = closeBtn

closeBtn.MouseEnter:Connect(function()
  tweenService:Create(closeBtn, TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(255, 50, 50),
  }):Play()
end)

closeBtn.MouseLeave:Connect(function()
  tweenService:Create(closeBtn, TweenInfo.new(0.2), {
    BackgroundColor3 = Color3.fromRGB(50, 50, 50),
  }):Play()
end)

local inputFrame = Instance.new("Frame")
inputFrame.Name = "InputFrame"
inputFrame.Size = UDim2.new(0.8, 0, 0, 45)
inputFrame.Position = UDim2.new(0.5, 0, 0.45, 0)
inputFrame.AnchorPoint = Vector2.new(0.5, 0.5)
inputFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
inputFrame.Parent = mainFrame

local uiCorner3 = Instance.new("UICorner")
uiCorner3.CornerRadius = UDim.new(0, 8)
uiCorner3.Parent = inputFrame

local uiStroke2 = Instance.new("UIStroke")
uiStroke2.Color = Color3.fromRGB(60, 60, 60)
uiStroke2.Thickness = 1
uiStroke2.Parent = inputFrame

local keyInput = Instance.new("TextBox")
keyInput.Name = "KeyInput"
keyInput.Size = UDim2.new(1, -20, 1, 0)
keyInput.Position = UDim2.new(0, 10, 0, 0)
keyInput.BackgroundTransparency = 1
keyInput.Text = ""
keyInput.PlaceholderText = "Enter your key here..."
keyInput.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
keyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
keyInput.Font = Enum.Font.GothamMedium
keyInput.TextSize = 14
keyInput.TextXAlignment = Enum.TextXAlignment.Left
keyInput.ClearTextOnFocus = false
keyInput.Parent = inputFrame

local btnContainer = Instance.new("Frame")
btnContainer.Name = "BtnContainer"
btnContainer.Size = UDim2.new(0.8, 0, 0, 45)
btnContainer.Position = UDim2.new(0.5, 0, 0.72, 0)
btnContainer.AnchorPoint = Vector2.new(0.5, 0.5)
btnContainer.BackgroundTransparency = 1
btnContainer.Parent = mainFrame

local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Name = "GetKeyBtn"
getKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
getKeyBtn.Position = UDim2.new(0, 0, 0, 0)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
getKeyBtn.Text = "GET KEY"
getKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 14
getKeyBtn.Parent = btnContainer

local uiCorner4 = Instance.new("UICorner")
uiCorner4.CornerRadius = UDim.new(0, 8)
uiCorner4.Parent = getKeyBtn

local loginBtn = Instance.new("TextButton")
loginBtn.Name = "LoginBtn"
loginBtn.Size = UDim2.new(0.48, 0, 1, 0)
loginBtn.Position = UDim2.new(0.52, 0, 0, 0)
loginBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
loginBtn.Text = "LOGIN"
loginBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
loginBtn.Font = Enum.Font.GothamBold
loginBtn.TextSize = 14
loginBtn.Parent = btnContainer

local uiCorner5 = Instance.new("UICorner")
uiCorner5.CornerRadius = UDim.new(0, 8)
uiCorner5.Parent = loginBtn

local footer = Instance.new("TextLabel")
footer.Name = "Footer"
footer.Size = UDim2.new(1, 0, 0, 20)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.Text = "POWERED BY SHENRU!"
footer.TextColor3 = Color3.fromRGB(80, 80, 80)
footer.Font = Enum.Font.GothamBold
footer.TextSize = 12
footer.TextXAlignment = Enum.TextXAlignment.Center
footer.Parent = mainFrame

local position, position2

local function f1(p1)
  local v2 = p1.Position - position

  mainFrame.Position = UDim2.new(
    position2.X.Scale, position2.X.Offset + v2.X, position2.Y.Scale, position2.Y.Offset + v2.Y
  )
end

local v3

mainFrame.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
    v3 = true
    position = input.Position
    position2 = mainFrame.Position

    input.Changed:Connect(function()
      if input.UserInputState == Enum.UserInputState.End then
        v3 = false
      end
    end)
  end
end)

local v4

mainFrame.InputChanged:Connect(function(input2)
  if input2.UserInputType == Enum.UserInputType.MouseMovement
    or input2.UserInputType == Enum.UserInputType.Touch then
    v4 = input2
  end
end)

userInputService.InputChanged:Connect(function(input3)
  if input3 == v4 and v3 then
    f1(input3)
  end
end)

mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.BackgroundTransparency = 1

blurEffect.Size = 0

tweenService:Create(
  mainFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
  { Size = UDim2.new(0, 400, 0, 280), BackgroundTransparency = 0 }
):Play()

tweenService:Create(blurEffect, TweenInfo.new(0.6), { Size = 15 }):Play()

local function f2(p2, backgroundColor3, backgroundColor32)
  p2.MouseEnter:Connect(function()
    tweenService:Create(p2, TweenInfo.new(0.2), {
      BackgroundColor3 = backgroundColor32,
      Size = UDim2.new(0.5, 0, 1.05, 0),
    }):Play()
  end)

  p2.MouseLeave:Connect(function()
    tweenService:Create(p2, TweenInfo.new(0.2), {
      BackgroundColor3 = backgroundColor3,
      Size = UDim2.new(0.48, 0, 1, 0),
    }):Play()
  end)
end

f2(getKeyBtn, Color3.fromRGB(180, 180, 180), Color3.fromRGB(220, 220, 220))
f2(loginBtn, Color3.fromRGB(255, 255, 255), Color3.fromRGB(200, 200, 200))

local function f3()
  local position3 = mainFrame.Position
  local count = 0

  while true do
    count = 1 + count

    if not (4 >= count) then
      break
    end

    tweenService:Create(mainFrame, TweenInfo.new(0.05), {
      Position = position3 + UDim2.new(0, 15, 0, 0),
    }):Play()

    task.wait(0.05)

    tweenService:Create(mainFrame, TweenInfo.new(0.05), {
      Position = position3 - UDim2.new(0, 15, 0, 0),
    }):Play()

    task.wait(0.05)
  end

  tweenService:Create(mainFrame, TweenInfo.new(0.05), { Position = position3 }):Play()
end

closeBtn.MouseButton1Click:Connect(function()
  tweenService:Create(blurEffect, TweenInfo.new(0.4), { Size = 0 }):Play()

  tweenService:Create(
    mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
    { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 }
  ):Play()

  task.wait(0.4)
  blurEffect:Destroy()
  shenruKeySystem:Destroy()
end)

getKeyBtn.MouseButton1Click:Connect(function()
  if v1 ~= "" then
    pcall(function() setclipboard(v1) end)
    getKeyBtn.Text = "COPIED!"
    task.wait(2)
    getKeyBtn.Text = "GET KEY"
  else
    getKeyBtn.Text = "FAILED!"
    task.wait(2)
    getKeyBtn.Text = "GET KEY"
  end
end)

loginBtn.MouseButton1Click:Connect(function()
  local text = keyInput.Text

  if text == "" then
    f3()
    return
  else
    loginBtn.Text = "CHECKING..."
    loginBtn.TextColor3 = Color3.fromRGB(150, 150, 150)

    local v5, v6 = pcall(function() return game:HttpGet("https://pastebin.com/raw/34ikEXg2") end)

    if v5
      and (string.find(v6, "\n" .. text .. "\n") or v6:sub(1, #text) == text
        or v6:sub(-#text) == text) then
      loginBtn.Text = "SUCCESS!"
      loginBtn.TextColor3 = Color3.fromRGB(0, 255, 0)

      task.wait(1)

      tweenService:Create(blurEffect, TweenInfo.new(0.4), { Size = 0 }):Play()

      tweenService:Create(
        mainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In),
        { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 }
      ):Play()

      task.wait(0.4)
      blurEffect:Destroy()
      shenruKeySystem:Destroy()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/johnandreisebastian791-lgtm/roblox-script-shenru/refs/heads/main/xinxaoscript-mvsd-devSHENRU.lua"))()
    else
      f3()

      loginBtn.Text = "INVALID KEY"
      loginBtn.TextColor3 = Color3.fromRGB(255, 0, 0)

      task.wait(2)

      loginBtn.Text = "LOGIN"
      loginBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end

    return
  end
end)
