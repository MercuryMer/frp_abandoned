include "autorun/sh_conf.lua"

local showAdminMode = false

local function toggleAdminMode()
   showAdminMode = not showAdminMode
end

hook.Add("HUDPaint", "ShowAdminMode", function()
   if showAdminMode then
    draw.RoundedBox(10, ScrW() / 2 - 100, ScrH() / 1.1 - 20, 200, 40, Color(0, 0, 0, 200)) 
    draw.SimpleText("ADMINMODE", "DermaLarge", ScrW() / 2, ScrH() / 1.1, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
   end
end)

net.Receive("toggleAdminMode", function()
   toggleAdminMode()
end)

hook.Add("PostPlayerDraw", "ShowAdminMode", function(ply)
   if showAdminMode then
      local pos = ply:GetPos() + Vector(0, 0, 90)
      local ang = Angle(0, LocalPlayer():EyeAngles().y - 90, 90)
      cam.Start3D2D(pos, ang, 0.25)
         if LocalPlayer():GetPos():Distance(ply:GetPos()) < 0.2 then
            draw.SimpleText("!ADMINMODE!", "DermaLarge", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
         end
      cam.End3D2D()
   end
end)
