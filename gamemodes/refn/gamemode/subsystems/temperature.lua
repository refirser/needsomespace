local tab = { };
tab.Name = "온도";
tab.Acronym = "TMP";
tab.Desc = "온도를 사람이 지낼 수 있는 온도로 조정하는 곳입니다. 파괴될 시 생명 유지에 위협이 됩니다.";
tab.Teams = { TEAM_ENG, TEAM_OFF };

tab.ASS = true;
tab.DamageType = DMG_BURN;

tab.OnDestroyed = function() end;
tab.DestroyedThink = function() end;

EXPORTS["temperature"] = tab;