local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Rain-Design/Unnamed/main/Library.lua"))()
Library.Theme = "Tokyo Night"
local Flags = Library.Flags

local mobstable = {"All"}
local eggsstable = {}
local eggmode = {1, 3}

for i, v in pairs(game:GetService("Workspace").Resources.NPCSpawns.Normal:GetChildren()) do
    if not table.find(mobstable, v.Name) then
        table.insert(mobstable, v.Name)
    end
end

for i, v in pairs(game:GetService("Workspace").Resources.EggStands:GetChildren()) do
    if not table.find(eggsstable, v.Name) then
        table.insert(eggsstable, v.Name)
    end
end

local Window =
    Library:Window(
    {
        Text = "Sword thigny simulator big balls"
    }
)

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local char = localPlayer.Character
local mobs
local farmtoggle
local _Distance = -7
local egg
local teleportmode = true
local KillAuraRange = 50
local equipbestdelay = 5

local _speed = 100

function tp(mode,...)
    if char:FindFirstChild("HumanoidRootPart") then else repeat wait(.1) until char:FindFirstChild("HumanoidRootPart") end
    if mode == nil then mode = true end
    local plr = game.Players.LocalPlayer
    local args = {...}
    if typeof(args[1]) == "number" and args[2] and args[3] then
        args = Vector3.new(args[1], args[2], args[3])
    elseif typeof(args[1]) == "Vector3" then
        args = args[1]
    elseif typeof(args[1]) == "CFrame" then
        args = args[1].Position
    end
    local dist = (plr.Character.HumanoidRootPart.Position - args).Magnitude
    local tween =
        game:GetService("TweenService"):Create(
        plr.Character.HumanoidRootPart,
        TweenInfo.new(dist / _speed, Enum.EasingStyle.Linear),
        {CFrame = CFrame.new(args)}
    )
    if mode == true then
    tween:Play()
    tween.Completed:Wait()
    else
    char:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(args)
    end
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function GetClosest(Range)
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
    if not (Character or HumanoidRootPart) then return end

    local TargetDistance = Range
    local Target

    for i,v in ipairs(game:GetService("Workspace").Live.NPCs.Client:GetChildren()) do
        if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("NPCTag") then
            local TargetHRP = v.HumanoidRootPart
            local mag = (HumanoidRootPart.Position - TargetHRP.Position).magnitude
            if mag < TargetDistance then
                TargetDistance = mag
                Target = v.Name
            end
        end
    end

    return Target
end

local Tab =
    Window:Tab(
    {
        Text = "Main"
    }
)

local Section =
    Tab:Section(
    {
        Text = "Stuffsss"
    }
)

local Section2 =
    Tab:Section(
    {
        Text = "Egg and pet stuffsssss"
    }
)

local Section3 =
    Tab:Section(
    {
        Text = "Misc stufffsss"
    }
)

local drop =
    Section:Dropdown(
    {
        Text = "Mobs",
        List = mobstable,
        Callback = function(v)
            mobs = v
        end
    }
)

local drop2 =
    Section2:Dropdown(
    {
        Text = "Eggs",
        List = eggsstable,
        Callback = function(v)
            egg = v
        end
    }
)

Section:Slider(
    {
        Text = "Distance",
        Default = -10,
        Minimum = -50,
        Maximum = 50,
        Callback = function(val)
            _Distance = val
        end
    }
)

Section:Toggle(
    {
        Text = "tween tp",
        Default = teleportmode,
        Callback = function(bool)
            teleportmode = bool
        end
    }
)

Section:Slider(
    {
        Text = "Speed",
        Default = 100,
        Minimum = 10,
        Maximum = 2500,
        Callback = function(val)
            _speed = val
        end
    }
)

Section2:Toggle(
    {
        Text = "Farm",
        Callback = function(bool)
            eggtrue = bool
        end
    }
)

Section:Toggle(
    {
        Text = "Farm",
        Callback = function(bool)
            farmtoggle = bool
        end
    }
)

Section:Toggle(
    {
        Text = "Auto ascend",
        Callback = function(bool)
            ascend = bool
        end
    }
)

Section3:Toggle(
    {
        Text = "Claim all chests",
        Callback = function(bool)
            claimchestall = bool
        end
    }
)

Section3:Toggle(
    {
        Text = "Kill aura",
        Callback = function(bool)
            Killaura = bool
        end
    }
)

Section3:Slider(
    {
        Text = "Kill aura range",
        Default = 50,
        Minimum = 10,
        Maximum = 100,
        Callback = function(val)
            KillAuraRange = val
        end
    }
)

Section3:Toggle(
    {
        Text = "Forge all weapons",
        Callback = function(bool)
            forgetrue = bool
        end
    }
)

Section3:Toggle(
    {
        Text = "Equip Best weapon",
        Callback = function(bool)
            equipbest = bool
        end
    }
)

Section3:Slider(
    {
        Text = "Equip best delay",
        Default = equipbestdelay,
        Minimum = 1,
        Maximum = 50,
        Callback = function(val)
            equipbestdelay = val
        end
    }
)

Section:Toggle(
    {
        Text = "Auto Power",
        Callback = function(bool)
            autoclick = bool
        end
    }
)

Section:Toggle(
    {
        Text = "Collect Orbs",
        Callback = function(bool)
            orbstoggle = bool
        end
    }
)

Tab:Select()

task.spawn(
    function()
        while task.wait() do
            if claimchestall then
                for i, v in pairs(game:GetService("Workspace").Live.Chests:GetChildren()) do
                    game:GetService("ReplicatedStorage").Packages.Knit.Services.ChestService.RF.ClaimChest:InvokeServer(v.Name)
                end
            end
        end
    end
)

task.spawn(
    function()
        while task.wait() do
            if autoclick then
                game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer()
            end
        end
    end
)

task.spawn(
    function()
        while task.wait() do
            if ascend then
                game:GetService("ReplicatedStorage").Packages.Knit.Services.AscendService.RF.Ascend:InvokeServer()
            end
        end
    end
)


--farm
task.spawn(
    function()
        while task.wait() do
            if farmtoggle then
                for i, v in pairs(game:GetService("Workspace").Live.NPCs.Client:GetChildren()) do
                    if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("NPCTag") and v:FindFirstChild("HumanoidRootPart").NPCTag.NameLabel.Text == mobs and farmtoggle == true then
                        repeat
                            tp(teleportmode, v.HumanoidRootPart.CFrame * Vector3.new(0, _Distance, 0))
                            game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer(v.Name)
                        until not v.HumanoidRootPart:FindFirstChild("NPCTag") or farmtoggle == false
                    elseif mobs == "All" and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("NPCTag") and farmtoggle == true then
                        repeat
                            tp(teleportmode, v.HumanoidRootPart.CFrame * Vector3.new(0, _Distance, 0))
                            game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer(v.Name)
                        until not v.HumanoidRootPart:FindFirstChild("NPCTag") or farmtoggle == false
                    end
                end
            end
        end
    end
)

task.spawn(
    function()
        while task.wait() do
            if orbstoggle then
                for i, v in pairs(game:GetService("Workspace").Live.Pickups:GetChildren()) do
                    v.CFrame = char.HumanoidRootPart.CFrame
                end
            end
        end
    end
)

task.spawn(
    function()
        while task.wait() do
            if Killaura then
                for i,v in ipairs(game:GetService("Workspace").Live.NPCs.Client:GetChildren()) do
                    if v.Name == GetClosest(KillAuraRange) and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("NPCTag") and Killaura == true then
                        game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer(v.Name)
                    end
                end
            end
        end
    end
)

task.spawn(
    function()
        while task.wait() do
            if eggtrue then
                game:GetService("ReplicatedStorage").Packages.Knit.Services.EggService.RF.BuyEgg:InvokeServer({["eggName"] = egg, ["auto"] = true, ["amount"] = 1})
            end
        end
    end
)


task.spawn(
    function()
        while task.wait() do
            if forgetrue then
                for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.WeaponInv.Background.ImageFrame.Window.WeaponHolder.WeaponScrolling:GetChildren()) do
                           game:GetService("ReplicatedStorage").Packages.Knit.Services.ForgeService.RF.Forge:InvokeServer(v.Name)
                end
            end
        end
    end
)

task.spawn(
    function()
        while task.wait() do
            if equipbest then
                wait(equipbestdelay)
             game:GetService("ReplicatedStorage").Packages.Knit.Services.WeaponInvService.RF.EquipBest:InvokeServer()
            end
        end
    end
)
