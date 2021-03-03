local tab = { };
tab.Name = "방사능";
tab.Acronym = "RAD";
tab.Desc = "내부에 태양 복사 및 폭풍이 침투하는 것을 방지합니다.";
tab.Teams = { TEAM_PRO };

tab.DestroyedPlayerSpeed = function( ply )

	return 0.7;
	
end

EXPORTS["radiation"] = tab;