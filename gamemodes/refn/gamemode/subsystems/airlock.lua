local tab = { };
tab.Name = "에어락 컨트롤러";
tab.Acronym = "ALC";
tab.Desc = "우주선의 에어락 상태를 관리하는 시스템입니다.";
tab.Teams = { TEAM_ENG, TEAM_PRO };

tab.OnDestroyed = function()

	for _, v in pairs( ents.FindByName( "ship_airlock" ) ) do

		v:Fire( "Open" );

	end

end;
tab.Restore = function()

	-- handled by game.CleanUpMap()

end;

EXPORTS["airlock"] = tab;