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

local _speed = 100

function tp(...)
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

    tween:Play()
    tween.Completed:Wait()
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
                            tp(v.HumanoidRootPart.CFrame * Vector3.new(0, _Distance, 0))
                            game:GetService("ReplicatedStorage").Packages.Knit.Services.ClickService.RF.Click:InvokeServer(v.Name)
                        until not v.HumanoidRootPart:FindFirstChild("NPCTag") or farmtoggle == false
                    elseif mobs == "All" and v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChild("NPCTag") and farmtoggle == true then
                        repeat
                            tp(v.HumanoidRootPart.CFrame * Vector3.new(0, _Distance, 0))
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
                    if v:IsA("Part") and char:FindFirstChild("HumanoidRootPart") then
                    v.CFrame = char:WaitForChild("HumanoidRootPart").CFrame
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
