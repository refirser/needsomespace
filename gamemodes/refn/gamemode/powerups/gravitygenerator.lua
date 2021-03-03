local tab = { };
tab.Name = "중력 발생기";
tab.Desc = "낮은 중력을 무시할 수 있습니다.";
tab.Ingredients = { "metal", "metal", "circuitry", "interface" };

tab.OnCreate = function( ply )

	ply:SetGravity( 1 );

end

EXPORTS["gravitygenerator"] = tab;