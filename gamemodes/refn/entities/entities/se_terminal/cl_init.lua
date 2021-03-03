include("shared.lua")

function ENT:Initialize()
  self.lines = {}
  self.userinput = ""
end
function ENT:Draw()
    self:DrawModel()
    local pos = self:LocalToWorld( Vector(0, -15, 50) )
    local ang = Angle(0, 90, 45) + self:GetAngles()
    cam.Start3D2D(pos, ang, 0.05)
      surface.SetDrawColor(5, 5, 5, 230);
      surface.DrawRect(0, 0, 600, 600);
      local pos = 0
      local slice_size = #self.lines - 25
      if slice_size < 1 then slice_size = 1 end
      for k, v in pairs(SliceTable(self.lines or {}, slice_size, #self.lines, 1)) do
        pos = k * 20
        draw.SimpleText(v or "", "TerminalFont", 20, pos, Color(0, 200, 0, 200), 0, 0);
      end
      pos = pos + 20
      draw.SimpleText(self.userinput, "TerminalFont", 20, pos, Color(0, 200, 0, 200), 0, 0);
    cam.End3D2D()

    cam.Start3D2D(self:LocalToWorld( Vector(20, -5, 28) ), Angle(0, 90, 90) + self:GetAngles(), 0.2)
      draw.SimpleText(self:GetNWString("se_terminal_name", "Terminal"), "TerminalFont", 20, 0, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER);
    cam.End3D2D()
end

function ENT:PrintLn(line)
  local output = textWrap(line, "TerminalFont", 580):Split("\n")
  for k, v in ipairs(output) do
    table.insert(self.lines, v)
  end
end

function ENT:Print(line)
  self.lines[#self.lines] = self.lines[#self.lines]..line
end

function ENT:ClearLines()
  self.lines = {}
end

function ENT:ChangeLastLine(line)
  self.lines[#self.lines] = line
end

function ENT:ChangeLine(line, index)
  self.lines[#self.lines - index] = line
end

function ENT:UserInput(line)
  self.userinput = line
end
