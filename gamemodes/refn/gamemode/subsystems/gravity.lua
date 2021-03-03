local tab = { };
tab.Name = "중력 발생기";
tab.Acronym = "GRV";
tab.Desc = "인공적으로 중력장을 생성합니다. 손상될 시 중력이 불안정해집니다.";
tab.Teams = { TEAM_PRO, TEAM_OFF };

tab.OnDestroyed = function()

	for _, v in pairs( player.GetAll() ) do

		if( v.Powerup != "gravitygenerator" ) then
			
			v:SetGravity( 0.2 );

		end

	end

	physenv.SetGravity( Vector( 0, 0, 0 ) );

end;
tab.OnDestroyedPlayerJoin = function( ply )

	ply:SetGravity( 0.2 );

end;
tab.Restore = function()

	for _, v in pairs( player.GetAll() ) do

		v:SetGravity( 1 );

	end

	physenv.SetGravity( Vector( 0, 0, -600 ) );

end;

EXPORTS["gravity"] = tab;