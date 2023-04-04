include "autorun/sh_conf.lua"

-- Bots Command
concommand.Add("bots", function(ply, cmd, args)
    if ply:IsAdmin() then
        for i = 1, args[1] do
            RunConsoleCommand("bot")
        end
    end
end)



util.AddNetworkString( "toggleAdminMode" )
function toggleAdminMode(ply)
    net.Start("toggleAdminMode")
    net.Send(ply)
end

local FRP_M = "{blue [FRP]} "

local function AddMsgply(ply, msg)
    ply:ChatPrint(msg)
end

local function MPlus(ply)
    local allowedRanks = {"moderator", "admin", "superadmin"}
    local playerRank = ply:GetUserGroup()
  
    for _, rank in pairs(allowedRanks) do
      if playerRank == rank then
        return true
      end
    end
  
    return false
end

local function APlus(ply)
    local allowedRanks = {"admin", "superadmin"}
    local playerRank = ply:GetUserGroup()
  
    for _, rank in pairs(allowedRanks) do
      if playerRank == rank then
        return true
      end
    end
  
    return false
end

hook.Add("PlayerSay", "adminmode", function(ply, text, team)
    if text == ".admin" then
        if MPlus(ply) then
            if ply:GetMoveType() == MOVETYPE_NOCLIP then
                ply:SetMoveType(MOVETYPE_WALK)
                toggleAdminMode(ply)

                return ""
            else
                ply:SetMoveType(MOVETYPE_NOCLIP)
                toggleAdminMode(ply)

                return ""
            end
        end
    end
end)

hook.Add("PlayerSay", "godmode", function(ply, text, team)
    if text == ".god" then
        if MPlus(ply) then
            if ply:HasGodMode() then
                ply:GodDisable()
                AddMsgply(ply, FRP_M .. "God Mode Disabled")

                return ""
            else
                ply:GodEnable()
                AddMsgply(ply, FRP_M .. "God Mode Enabled")

                return ""
            end
        end
    end
end)

hook.Add("PlayerSay", "getmodel", function(ply, text, team)
    if MPlus(ply) then
        if text == ".getmodel" then
            local tr = ply:GetEyeTrace()
            local ent = tr.Entity

            if IsValid(ent) then
                AddMsgply(ply, FRP_M .. (ent:GetModel()))

                return ""
            else
                AddMsgply(ply, FRP_M .. "You are not looking at anything")

                return ""
            end
        end
    end
end)

hook.Add("PlayerSay", "addbots", function(ply, text, team)
    if APlus(ply) then
        if text == ".bots" then
            RunConsoleCommand("bots", 5)
            AddMsgply(ply, FRP_M .. "Bots added!")

            return ""
        end
    end
end)

hook.Add("PlayerSay", "telecommand", function(ply, text, team)
    if MPlus(ply) then
        if text == ".ar" then
            ply:SetPos(ADMINROOM)
            AddMsgply(ply, FRP_M .. "You are now in the Admin Room!")

            return ""
        elseif text == ".return" then
            local spawn = math.random(1, 5)
            ply:SetPos(SPAWNS[spawn])
            AddMsgply(ply, FRP_M .. "You have returned yourself")

            return ""
        end
    end
end)
