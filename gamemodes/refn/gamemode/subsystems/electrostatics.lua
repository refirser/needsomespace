local tab = { };
tab.Name = "정전기 쉴드";
tab.Acronym = "FRI";
tab.Desc = "먼지 입자가 표면에 들러붙지 않게 하여 정전기를 방지합니다. 파괴될 시 마찰력이 감소합니다.";
tab.Teams = { TEAM_PRO };

tab.OnDestroyed = function()

	if( SERVER ) then
		
		game.ConsoleCommand( "sv_friction 1\n" );

	end

end;
tab.Restore = function()

	if( SERVER ) then
		
		game.ConsoleCommand( "sv_friction 8\n" );

	end

end;

EXPORTS["electrostatics"] = tab;