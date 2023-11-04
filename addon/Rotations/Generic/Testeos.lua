local queue = {
    "Posicion"
};

local abilities = {
    ["Posicion"] = function()
        print("salami")
        print(ni.unit.info(booberGUID))
        print("player", "->", ni.unit.info("player"))
    end,
};

ni.bootstrap.profile("testeos", queue, abilities)