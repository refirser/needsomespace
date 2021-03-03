local tab = { };
tab.Name = "인트라넷 브라우저";
tab.Desc = "시스템을 수리하는데 드는 시간이 50%로 감소됩니다.";
tab.Ingredients = { "interface", "circuitry", "circuitry", "circuitry" };

tab.FaultMul = 2;

EXPORTS["intranetbrowser"] = tab;