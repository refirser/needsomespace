
function util.CreateBlurBackGroundPanel(panel, density, alpha)
	local blur = Material( "pp/blurscreen" )
	local x, y = panel:LocalToScreen(0, 0)
	surface.SetDrawColor( 255, 255, 255, alpha )
	surface.SetMaterial( blur )
	for i = 1, 3 do
		blur:SetFloat( "$blur", ( i ) * density )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( -x, -y, panel:GetWide(), panel:GetTall() )
	end	
end

function util.CreateBlurBackGround(x, y, w, h, density, alpha)
	local X, Y = 0,0
		local blur = Material( "pp/blurscreen" )
		surface.SetDrawColor(255,255,255)
		surface.SetMaterial(blur)

		for i = 1, 2 do
			blur:SetFloat("$blur", (i) * (density))
			blur:Recompute()

			render.UpdateScreenEffectTexture()

			render.SetScissorRect(x, y, x+w, y+h, true)
				surface.DrawTexturedRect(X * -1, Y * -1, ScrW(), ScrH())
			render.SetScissorRect(0, 0, 0, 0, false)
		end
   
   draw.RoundedBox(0,x,y,w,h,Color(0,0,0,alpha))
   surface.SetDrawColor(0,0,0)
end

Fonts = {
	[ 'Tahoma' ] = 'Tahoma',
	[ 'Gothic' ] = 'Gothic',
	[ 'GothicBold' ] = 'GothicBold',
	[ 'Roboto' ] = 'Roboto Light',
}

CFont = CFont or false

if not CFont then
	for k, v in pairs( Fonts ) do
		for i = 15, 60 do
			surface.CreateFont( k .. '_' .. i, { font = v, size = i, weight = 500, antialias = true, extended = true } )		
		end
	end
	CFont = true
end

	

if scoreboard ~= nil then
	if scoreboard.main ~= nil then
		if scoreboard.main:IsValid() then
			scoreboard.main:Remove()
		end
	end
end

scoreboard = {} 

function scoreboard.Create()
	scoreboard.init = true
	
	local w, h = ScrW(), ScrH()
	
	scoreboard.main = vgui.Create("DFrame")
		scoreboard.main:SetPos(0, -h)
		scoreboard.main:LerpPositions(1, true)
		scoreboard.main:SetPos(0, 0)
		scoreboard.main:SetSize(w, h)
		scoreboard.main:SetTitle("")
		scoreboard.main:Center()
		scoreboard.main:MakePopup()
		scoreboard.main:SetDraggable(false)
		scoreboard.main:ShowCloseButton(false)
		scoreboard.main.Paint = function(self, w, h)
			draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
			
			util.CreateBlurBackGroundPanel(self, 3, 200)
			
			draw.SimpleText("우주 수리공", "GothicBold_40", w/2, 40, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			
			--local timestr = roundtime != -1 && roundtime && string.ToMinutesSeconds(roundtime - CurTime()) or "라운드가 진행되고 있지 않습니다."
			--draw.SimpleText(string.lower(game.GetMap()) .. "   -   감옥 탈출, " .. ROUND[2].time/60 .. " 분   -   남은 시간:" .. timestr, "Gothic_28", w/2, 85, Color(255,255,255,255), TEXT_ALIGN_CENTER)
			
			//BLUE SCORE
			
			surface.SetMaterial(Material("gui/gradient_up"));
			surface.SetDrawColor(200, 200, 200, 130)
			surface.DrawTexturedRect(100, 128, w/2-105, 30)
			draw.RoundedBox(0, 100, 128, w/2 - 105, 30, Color(200, 200, 200, 130)) 
			
			draw.SimpleText("차단", "Gothic_20", 120, 143, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("ID", "Gothic_20", 160, 143, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("랭크", "Gothic_20", 200, 143, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("핑", "Gothic_20", 100 + (w/2 - 105) - 25, 143, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("팀", "Gothic_20", 100 + (w/2 - 105) - 100, 143, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

			
			//RED SCORE
			surface.SetMaterial(Material("gui/gradient_up"));
			surface.SetDrawColor(100, 100, 100, 130)
			surface.DrawTexturedRect(100 + (w/2-105+10), 128, w/2-105, 30)
			draw.RoundedBox(0, 100 + (w/2-105+10), 128, w/2 - 105, 30, Color(100, 100, 100, 130))
			
			draw.SimpleText("접속중인 유저", "Gothic_20", (w/2-105+10) + 110, 143, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		
		local w,h = scoreboard.main:GetWide(), scoreboard.main:GetTall();
		local scroll = vgui.Create("DScrollPanel", scoreboard.main)
			scroll:SetSize(w/2-105, h - 230)
			scroll:SetPos(100, 158)
		function scroll:Paint(w,h)

		end
		
		local sbar = scroll:GetVBar();
		function sbar.btnGrip:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		end
		function sbar.btnUp:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		end
		function sbar.btnDown:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		end
		
		local list = vgui.Create("DIconLayout", scroll)
			list:SetSize(scroll:GetWide(), scroll:GetTall())
			list:SetPos(0,0)
		function list:Paint(w,h)
		end
		
		for k, v in pairs(player.GetAll()) do
			if v:Team() == TEAM_UNJOINED then continue end
			local item = list:Add("DPanel")
				item:SetSize(list:GetWide(), list:GetTall()/15+1)
				item:SetPos(0,0)
			function item:Paint(w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
				
				draw.RoundedBox(0, 0, 0, w, 1, Color(50,50,50,255))
					
				draw.RoundedBox(0, 40, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, 80, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, 120, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, w-50, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, w-150, 0, 1, h, Color(50,50,50,255))
			
				draw.SimpleText(k, "Gothic_20", 60, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(v:Nick(), "Gothic_20", 130, h/2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				draw.SimpleText(v:Ping(), "Gothic_20", w - 25, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(team.GetName(v:Team()), "Gothic_20", w - 100, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			
			local mute = vgui.Create("DButton", item)
				mute:SetText("")
				mute:SetPos(0, 0)
				mute:SetSize(40, item:GetTall())
			function mute:OnCursorEntered()
				self.cursor = true;
			end
			function mute:OnCursorExited()
				self.cursor = nil;
			end
			function mute:Paint(w,h)
				local alpha = 255;
				if self.cursor then
					alpha = 255;
				else
					alpha = 100;
				end
			
				if v:IsMuted() then
					draw.SimpleText("해제", "Gothic_20", w/2, h/2, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("차단", "Gothic_20", w/2, h/2, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			function mute:DoClick()
				if v:IsMuted() then
					v:SetMuted(false)
				else
					v:SetMuted(true)
				end
			end
		end
		
		local w,h = scoreboard.main:GetWide(), scoreboard.main:GetTall();
		local scroll = vgui.Create("DScrollPanel", scoreboard.main)
			scroll:SetSize(w/2-105, h - 230)
			scroll:SetPos(100+(w/2-105+10), 158)
		function scroll:Paint(w,h)

		end
		
		local sbar = scroll:GetVBar();
		function sbar.btnGrip:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		end
		function sbar.btnUp:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		end
		function sbar.btnDown:Paint(w,h)
			draw.RoundedBox(0, 0, 0, w, h, Color(255,255,255,255))
		end
		
		local list = vgui.Create("DIconLayout", scroll)
			list:SetSize(scroll:GetWide(), scroll:GetTall())
			list:SetPos(0,0)
		function list:Paint(w,h)
		end
		
		for k, v in pairs(team.GetPlayers(TEAM_UNJOINED)) do
			local item = list:Add("DPanel")
				item:SetSize(list:GetWide(), list:GetTall()/15+1)
				item:SetPos(0,0)
			function item:Paint(w,h)
				draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))
			
				draw.RoundedBox(0, 0, 0, w, 1, Color(50,50,50,255))
					
				draw.RoundedBox(0, 40, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, 80, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, 120, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, w-50, 0, 1, h, Color(50,50,50,255))
				draw.RoundedBox(0, w-150, 0, 1, h, Color(50,50,50,255))
			
				draw.SimpleText(k, "Gothic_20", 60, h/2, Color(255,255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText(v:Nick(), "Gothic_20", 130, h/2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
			
			local mute = vgui.Create("DButton", item)
				mute:SetText("")
				mute:SetPos(0, 0)
				mute:SetSize(40, item:GetTall())
			function mute:OnCursorEntered()
				self.cursor = true;
			end
			function mute:OnCursorExited()
				self.cursor = nil;
			end
			function mute:Paint(w,h)
				local alpha = 255;
				if self.cursor then
					alpha = 255;
				else
					alpha = 100;
				end
			
				if v:IsMuted() then
					draw.SimpleText("해제", "Gothic_20", w/2, h/2, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				else
					draw.SimpleText("차단", "Gothic_20", w/2, h/2, Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
			function mute:DoClick()
				if v:IsMuted() then
					v:SetMuted(false)
				else
					v:SetMuted(true)
				end
			end
		end
	
	gui.EnableScreenClicker(true)
end

function scoreboard.Remove()
	scoreboard.init = false
	
	if scoreboard.main ~= nil then
		if scoreboard.main:IsValid() then
			scoreboard.main:Remove()
		end
	end
	
	gui.EnableScreenClicker(false)
end

function scoreboard.check()
	return scoreboard.init
end

function GM:ScoreboardShow()
	if !scoreboard.init then
		scoreboard.Create()
	end
end

function GM:ScoreboardHide()
	if scoreboard.check() then
		scoreboard.Remove()
	end
end
