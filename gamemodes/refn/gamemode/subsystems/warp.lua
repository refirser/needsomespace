local tab = { };
tab.Name = "워프";
tab.Acronym = "WRP";
tab.Desc = "광속 드라이브를 제어하여 빛보다 빠른 이동을 가능하게 합니다. 파괴될 시 결과를 예측할 수 없습니다.";
tab.Teams = { TEAM_ENG, TEAM_PRO, TEAM_OFF };

local mat;
if( CLIENT ) then
	mat = CreateMaterial( "nss_warp_" .. CurTime(), "UnlitGeneric", {
		["$basetexture"] = "vgui/white",
		["$translucent"] = "1"
	} );
end

tab.DestroyedPostDrawSkybox = function()

	if( !GAMEMODE.NextWarpFlash ) then
		GAMEMODE.NextWarpFlash = CurTime();
	end

	if( CurTime() >= GAMEMODE.NextWarpFlash and GAMEMODE:GetState() == STATE_GAME ) then
		GAMEMODE.NextWarpFlash = CurTime() + math.Rand( 3, 7 );

		GAMEMODE.WarpFlashTime = CurTime();

		GAMEMODE:SetSkybox( "nss_" .. math.random( 1, 3 ) );

		EmitSound( Sound( "ambient/machines/machine1_hit" .. math.random( 1, 2 ) .. ".wav" ), LocalPlayer():EyePos(), LocalPlayer():EntIndex(), CHAN_AUTO, 0.3, 120, 0, math.random( 80, 120 ) );
	end

	if( GAMEMODE.WarpFlashTime ) then
		local t = math.Clamp( CurTime() - GAMEMODE.WarpFlashTime, 0, 0.25 );
		local a = 1 - ( t * 4 );
		
		if( a > 0 ) then
			mat:SetFloat( "$alpha", a );
			render.SetMaterial( mat );
			render.DrawScreenQuad();
		end
	end

end;

tab.Restore = function()

	if( CLIENT ) then
		GAMEMODE:SetSkybox( "nss_1" );
	end

end

EXPORTS["warp"] = tab;