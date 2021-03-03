local tab = { };
tab.Name = "산소";
tab.Acronym = "OXY";
tab.Desc = "산소 공급기를 제어합니다. 파괴될 시 생명 유지에 위협이 발생합니다.";
tab.Teams = { TEAM_ENG };

tab.ASS = true;
tab.DamageType = DMG_GENERIC;

tab.OnDestroyed = function() end;
tab.DestroyedThink = function() end;

EXPORTS["oxygen"] = tab;