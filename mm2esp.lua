local Players = game:GetService("Players")
local me=Players.LocalPlayer

local red=Color3.fromRGB(255,60,60)
local blue=Color3.fromRGB(60,140,255)
local green=Color3.fromRGB(60,220,100)

local win=lw.ui.window("Murder Mystery 2",{size=Vector2.new(700,480)})
local sec=win:tab("Main"):section("Role ESP","left")

local murd,sher,innocent,selfesp=true,true,true,false

sec:toggle("Murderer ESP",true,function(v) murd=v end)
sec:toggle("Sheriff ESP",true,function(v) sher=v end)
sec:toggle("Innocent ESP",true,function(v) innocent=v end)
sec:toggle("Self ESP",false,function(v) selfesp=v end)

local function role(p)
    local knife,gun=false,false
    local function scan(c)
        if c then
            for _,v in c:GetChildren() do
                local n=v.Name:lower()
                if n=="knife" then knife=true
                elseif n=="gun" then gun=true end
            end
        end
    end

    scan(p:FindFirstChild("Backpack"))
    scan(p.Character)

    if knife and not gun then return "murd" end
    if gun and not knife then return "sher" end
    return "innocent"
end

while true do
    for _,p in Players:GetPlayers() do
        local char=p.Character
        local hum=char and char:FindFirstChildOfClass("Humanoid")
        local col=nil

        if char and hum and hum.Health>0 then
            local r=role(p)

            if r=="murd" and murd then col=red
            elseif r=="sher" and sher then col=blue
            elseif r=="innocent" and innocent then col=green end

            if p==me and not selfesp then col=nil end
            if col then
                lw.esp(char,{color=col,distance=true})
            else
                lw.esp(char,false)
            end
        elseif char then
            lw.esp(char,false)
        end
    end
    task.wait(.5)
end

