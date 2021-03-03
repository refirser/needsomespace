local tab = { };
tab.Name = "의료킷";
tab.Desc = "받는 데미지가 3/1로 감소합니다.";
tab.Ingredients = { "interface", "interface", "circuitry", "interface" };

tab.DamageMul = 0.333;

EXPORTS["medkit"] = tab;