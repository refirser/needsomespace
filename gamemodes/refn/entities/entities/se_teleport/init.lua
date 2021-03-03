AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
  self:SetModel("models/props_combine/combine_teleportplatform.mdl")
  self:SetSolid(SOLID_BBOX)
  self:SetUseType(SIMPLE_USE)
end

function ENT:Use(acticator, caller)
  caller:SetPos(Vector(-1859, -981, 32))
  caller.on_planet = false
end
