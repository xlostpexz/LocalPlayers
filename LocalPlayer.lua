local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/GreenDeno/Venyx-UI-Library/main/source.lua"))()
local venyx = library.new("Winnable Hub | LocalPlayers", 5013109572)
 
 
 
local page = venyx:addPage("LocalPlayers", 5012544693)
local section1 = page:addSection("LocalPlayers")
local theme = venyx:addPage("Setting", 5012544693)
local colors = theme:addSection("Setting")

section1:addButton("Fake Headless",function()
game.Players.LocalPlayer.Character.Head.Transparency = 1
game.Players.LocalPlayer.Character.Head.face:Destroy()
end)

section1:addSlider("WalkSpeed",16,0,300,function(t)
  game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
end)
section1:addSlider("JUMP POWER", 50, 25, 300, function(s)
   game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)
section1:addToggle("Fly",false,function(Value)
    Fly = Value
    activatefly()
end)
Fly = false
function activatefly()
    local mouse=game.Players.LocalPlayer:GetMouse''
    localplayer=game.Players.LocalPlayer
    game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local torso = game.Players.LocalPlayer.Character.HumanoidRootPart
    local speedSET = _G.Speed
    local keys={a=false,d=false,w=false,s=false}
    local e1
    local e2
    local function start()
        local pos = Instance.new("BodyPosition",torso)
        local gyro = Instance.new("BodyGyro",torso)
        pos.Name="EPIXPOS"
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = torso.Position
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        gyro.cframe = torso.CFrame
        repeat
            wait()
            localplayer.Character.Humanoid.PlatformStand=true
            local new=gyro.cframe - gyro.cframe.p + pos.position
            if not keys.w and not keys.s and not keys.a and not keys.d then
                speed=1
            end
            if keys.w then
                new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed=speed+speedSET
            end
            if keys.s then
                new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                speed=speed+speedSET
            end
            if keys.d then
                new = new * CFrame.new(speed,0,0)
                speed=speed+speedSET
            end
            if keys.a then
                new = new * CFrame.new(-speed,0,0)
                speed=speed+speedSET
            end
            if speed>speedSET then
                speed=speedSET
            end
            pos.position=new.p
            if keys.w then
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*15),0,0)
            elseif keys.s then
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*15),0,0)
            else
                gyro.cframe = workspace.CurrentCamera.CoordinateFrame
            end
        until not Fly
        if gyro then 
            gyro:Destroy() 
        end
        if pos then 
            pos:Destroy() 
        end
        flying=false
        localplayer.Character.Humanoid.PlatformStand=false
        speed=0
    end
    e1=mouse.KeyDown:connect(function(key)
        if not torso or not torso.Parent then 
            flying=false e1:disconnect() e2:disconnect() return 
        end
        if key=="w" then
            keys.w=true
        elseif key=="s" then
            keys.s=true
        elseif key=="a" then
            keys.a=true
        elseif key=="d" then
            keys.d=true
        end
    end)
    e2=mouse.KeyUp:connect(function(key)
        if key=="w" then
            keys.w=false
        elseif key=="s" then
            keys.s=false
        elseif key=="a" then
            keys.a=false
        elseif key=="d" then
            keys.d=false
        end
    end)
    start()
end
_G.Speed = 25
section1:addSlider("Speed Fly",_G.Speed,5,75,function(t)
    _G.Speed = t
end)
section1:addToggle("NoClip",nil,function(value)
  _G.NoClip = value
end)
spawn(function()
  while game:GetService("RunService").Stepped:wait(10) do
      character = game.Players.LocalPlayer.Character 
      if _G.NoClip then
          pcall(function()
              for _, v in pairs(character:GetDescendants()) do
                  pcall(function()
                      if v:IsA("BasePart") then
                          pcall(function()
                          v.CanCollide = false
                          end)
                      end
                  end)
              end
          end)
      end
  end
end)

local themes = {
Background = Color3.fromRGB(24, 24, 24),
Glow = Color3.fromRGB(60, 0, 200),
Accent = Color3.fromRGB(10, 10, 10),
LightContrast = Color3.fromRGB(20, 20, 20),
DarkContrast = Color3.fromRGB(14, 14, 14),  
TextColor = Color3.fromRGB(241, 146, 255)
}
 
for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
colors:addColorPicker(theme, color, function(color3)
venyx:setTheme(theme, color3)
end)
end
 
-- load
venyx:SelectPage(venyx.pages[1], true)


colors:addKeybind("Toggle Keybind", Enum.KeyCode.RightControl, function()
print("Activated Keybind")  
venyx:toggle()
end, function()
game.StarterGui:SetCore("SendNotification", {
Title = "Keybind";
Text = "Change Keybind Success";
Duration = "10";
})
end)
