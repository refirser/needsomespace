AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
  self:SetModel("models/props_combine/combine_interface001.mdl")
  self:SetSolid(SOLID_VPHYSICS)
  self:SetUseType(SIMPLE_USE)
end

function ENT:Think()
  local hp = (players_spaceship.modules[self.ModuleName].health or 100) * 2
  self:SetColor(Color(255, 255 - (200 - hp), 255 - (200 - hp)))
end

function ENT:OnTakeDamage(damage)
  local hp = players_spaceship.modules[self.ModuleName].health
  if hp < 0 then
    local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    util.Effect( "HelicopterMegaBomb", effectdata )

    self:Ignite(30, 300)
  end
  if hp > 0 then
    players_spaceship.modules[self.ModuleName].health = hp - (damage:GetDamage() / 5)
  else
    players_spaceship.modules[self.ModuleName].health = 0
  end

end

function ENT:Use(activator, caller)
  if !IsValid(caller) then return end
  caller:SetNWEntity("ActiveTerminal", self)
  net.Start("se_terminal_start_type")
  net.WriteEntity(self)
  net.Send(caller)
end

function ENT:PrintLn(line)
  net.Start("se_terminal_println")
  net.WriteEntity(self)
  net.WriteString(line)
  net.Broadcast()
end

function ENT:ClearLines()
  net.Start("se_terminal_clear")
  net.WriteEntity(self)
  net.Broadcast()
end

function ENT:ChangeLine(line, index)
  net.Start("se_terminal_changeline")
  net.WriteEntity(self)
  net.WriteString(line)
  net.WriteInt(index, 32)
  net.Broadcast()
end

function ENT:Print(line)
  net.Start("se_terminal_print")
  net.WriteEntity(self)
  net.WriteString(line)
  net.Broadcast()
end

function ENT:ChangeUI(name, ply)
  net.Start("se_change_module_ui")
  net.WriteInt(self:EntIndex(), 32)
  net.WriteString(name)
  net.Send(ply)
end
