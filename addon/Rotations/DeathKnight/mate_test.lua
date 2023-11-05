local t4=0
local enables = {
    ["target"] = true,
    ["escudo_oseo"] = true,
    ["cuerno"] = true,
    ["pet"] = true,
    ["presencias"] = true,
    ["ik"] = true,
    ["lana"] = true,
    ["entereza"] = true,
    ["pacto_pet"] = true,
    ["kamen"] = true,
    ["pestilencia"] = true,
    ["pestilencia_aoe"] = true,
    ["kick"] = false,
    ["kick_2"] = false,
    ["kick_3"] = false,
    ["debug"] = false,
}
local values = {
    kamen = 35,
        pacto_pet = 20,
        entereza = 30,
}
local inputs = {
    kiick = "",
}
local menus = {
}
local function GUICallback(key, item_type, value)
	if item_type == "enabled" then
		enables[key] = value;
	elseif item_type == "value" then
		values[key] = value;
	elseif item_type == "input" then
		inputs[key] = value;
	elseif item_type == "menu" then
		menus[key] = value;
	end
end
local items = {
    settingsfile = "adk_4t4_by_makaren.json",
    callback = GUICallback,
    { type = "title", text = "AutoDkProfano by |c0000CED1Matecitos|r" },
	{ type = "separator" },
        { type = "title", text = "|cffFF7C0AProfile version 1.5.0|r" },
        { type = "separator" },
        { type = "page", number = 1, text = "|cffFFFF00ajustes generales|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(6603).." Auto targeting", tooltip ="Selecciona automáticamente un objetivo cuando no hay uno", enabled = true, key = "target" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(48265).." Cambio de puntales", tooltip ="Cambio automático de puntales", enabled = true, key = "presencias" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(57623).." cuerno Automatico", tooltip ="Utiliza automáticamente cuerno cuando no lo tienes .", enabled = true, key = "cuerno" },
        { type = "entry", text = ni.spell.icon(49222).." Auto Bone Shield", tooltip ="Utiliza automáticamente el Escudo Óseo si no está presente.", enabled = true, key = "escudo_oseo" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(46584).." Auto call Necrofago", tooltip ="Saca al necrofago automaticamente", enabled = true, key = "pet" },
        { type = "separator" },
    { type = "entry", text = ni.spell.icon(24803).." Mostrar depuracion en chat", enabled = false, key = "debug" },
        { type = "page", number = 2, text = "|cffFFFF00Ajustes avanzados|r" },
    	{ type = "separator" },	
	{ type = "entry", text = ni.spell.icon(50842).." Renovar pestes con pestielecia", tooltip ="Actualizar pestes co POestilencia", enabled = true, key = "pestilencia" },
        { type = "entry", text = ni.spell.icon(50842).." epstilencia para AoE", tooltip ="Usar pestilencia para propagar pestes", enabled = true, key = "pestilencia_aoe" },
	{ type = "separator" },
    { type = "entry", text = ni.spell.icon(47528).." Autokick", tooltip ="Interrumpe todos los hechizos", enabled = false, key = "kick" },
    { type = "entry", text = " dentro del alcance", tooltip ="Interrumpe a todos los que estén dentro del alcance (no sólo al objetivo)", enabled = false, key = "kick_2" },
    { type = "entry", text = " kick espesifico", tooltip ="Interrumpe solo una spell especifica:", enabled = false, key = "kick_3" },
    {
		type = "input",
		value = inputs["kiick"],
		width = 140,
		height = 15,
		key = "kiick"
	},
        { type = "page", number = 3, text = "|cffFFFF00Verde|r" },
        { type = "entry", text = ni.spell.icon(48707)},
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(300996).." La llama de la legiOn", tooltip ="|cFF00FFFFИк/Ивк(Jaraxxus)|r", enabled = true, key = "ik" },
        { type = "entry", text = ni.spell.icon(71264).." Enjambre de sombras", tooltip ="|cFF00FFFFЦлк(Lana'atel)|r", enabled = true, key = "lana" },
        { type = "page", number = 4, text = "|cffFFFF00cajas fuertes|r" },
        { type = "separator" },
        { type = "entry", text = ni.spell.icon(48792).." Entereza ligada al Hielo", tooltip ="Usar entereza ligada al Hielo para |cFF00FF00Hp <|r\
Работает в связке e функцией TTD(Time To Die)", enabled = true, value = 40, min = 1, max = 100, step = 1, key = "entereza" },
        { type = "entry", text = ni.spell.icon(48743).." Pacto de muerte", tooltip ="Usar pacto de muerte en |cFF00FF00Hp <|r\
Работает в связке e функцией TTD(Time To Die)", enabled = true, value = 20, min = 1, max = 100, step = 1, key = "pacto_pet" },
        { type = "entry", text = ni.spell.icon(11729).." Piedra de la Salud", tooltip ="Usar pepino en |cFF00FF00Hp <|r\
Работает в связке e функцией TTD(Time To Die)", enabled = true, value = 30, min = 1, max = 100, step = 1, key = "kamen" },
	{ type = "page", number = 5, text = "|cffFFFF00Umblal de vida baja|r" },
    	{ type = "separator" },
	 { type = "input", text = "Valor de Kamen", tooltip = "Introduce un nuevo valor para Kamen", value = tostring(kamen), key = "KamenValue" },
    
    };
local function OnLoad()
	ni.GUI.AddFrame("adk_4t4_by_makaren", items);
end;
local function OnUnLoad()  
	ni.GUI.DestroyFrame("adk_4t4_by_makaren");
end;
local cache = {
    sindra = false,
    PlayerCombat = false,
    aoe = false,
    info = true,
    dots = false,
    dots_obnov = false,
    pet = true,
    control = false,
    };
local spells = {
    golpe_runa = GetSpellInfo(56815),
    cuerno = GetSpellInfo(57623),
    escudo_oseo = GetSpellInfo(49222),
    pet = GetSpellInfo(46584),
    cadenas = GetSpellInfo(45524),
    golpe_peste = GetSpellInfo(49921),
    golpe_plaga = GetSpellInfo(55271),
    muerte_y_desc = GetSpellInfo(49938),
    gargola = GetSpellInfo(49206),
    lik = GetSpellInfo(49895),
    golpe_mortal = GetSpellInfo(49924),
    golpe_sangriento = GetSpellInfo(49930),
    pestilencia = GetSpellInfo(50842),
    presencia_escarcha = GetSpellInfo(48263),
    char_rass = GetSpellInfo(316432),
    potenciar_runas = GetSpellInfo(47568),
    p_sangre = GetSpellInfo(48266),
    p_profana = GetSpellInfo(48265),
    transfusion = GetSpellInfo(45529),
    caparazon = GetSpellInfo(48707),
    entereza = GetSpellInfo(48792),
    pacto_pet = GetSpellInfo(48743),
    kick = GetSpellInfo(47528),

    };
local ddebuffs ={
    sindra = GetSpellInfo(69766),
    sindra_metka = GetSpellInfo(70126),
    }
local queue = {
    "golpe_mortal",
    "info",
    "Totem Smash",
    "cache",
    "pause",
    "auto-target",
    "kick",
    "golpe_runa",
    "cd",
    "p_profana",
    "save",
    "Frost_defensive",
    "caparazon",
    "pestilencia",
    "pestilencia_aoe",
    "buff",
    "cadenas",
    "golpe_peste",
    "golpe_sangriento",
    "golpe_plaga",
    "char_rass",
    "lik_buf",
    "gargola",
    "gargola_Buffed",
    "potenciar_runas",
    "p_sangre",
    "lik",
};
local abilities = {
    -----------------------------------
    ["info"] = function()
        if cache.info == true
        and not ni.vars.coin then
            cache.info = false
            print("|cFFFF0000 =========================|r\
|Perfil privado de Mate|r\
|Perfil privado de Mate|r\
|Fanpei https://funpay.com/users/7303789/|r\
|cFF00FFFFДс https://discord.com/users/785141640087207966|r\
|https://discord.gg/eQzcDHbVfm.|r\
|cFFFF0000=========================|r")
        end
    end,
    

    ["Totem Smash"] = function()
        for k, v in pairs(ni.objects) do
            if type(k) ~= "function" and (type(k) == "string" and type(v) == "table") then
                if ni.unit.istotem(k) 
                    and UnitCanAttack("player", k) then
               local name = UnitName(k);
                  if name == "Tótem derribador" 
                  or name == "Tótem Nexo Terrestre" 
                  or name == "Stoneskin Totem" 
                  or name == "Totem of Wrath" 
                  or name == "Tremor Totem" 
                  or name == "Windfury Totem"
                  or name == "Wrath of Air Totem" then
                    local target = UnitGUID("target");
                    ni.player.target(k);
                    ni.player.runtext("/petattack");
                    ni.player.target(target);
                    return true;
                  end
                end
            end
        end
    end,    
    ------------------------
    ["cache"] = function()
        cache.PlayerCombat = UnitAffectingCombat("player") or false;
        cache.sindra = ni.unit.debuffstacks("player", "Пронизывающая стужа") <= 7;
        if ni.unit.debuff("target", 55078, "player")
        and ni.unit.debuff("target", 55095, "player") then
            cache.dots = true
        else
            cache.dots = false
        end
        if ni.unit.debuffremaining("target", 55095, "player") < 2
        or ni.unit.debuffremaining("target", 55078, "player") < 2 then
            cache.dots_obnov = true
        else
            cache.dots_obnov = false
        end
        if ni.unit.debuff("target", "Сглаз") 
        or ni.unit.debuff("target", "Устрашающий крик") 
        or ni.unit.debuff("target", "Гнев деревьев") 
        or ni.unit.debuff("target", "Смерч") 
        or ni.unit.debuff("target", "Превращение") 
        or ni.unit.debuff("target", "Замораживающая ловушка") 
        or ni.unit.debuff("target", "Покаяние") 
        or ni.unit.debuff("target", "Ослепление") 
        or ni.unit.debuff("target", "Ошеломление") 
        or ni.unit.debuff("target", "Вой ужаса") 
        or ni.unit.debuff("target", "Изгнание") 
        or ni.unit.debuff("target", "Страх") 
        or ni.unit.debuff("target", "Спячка") 
        or ni.unit.debuff("target", "Отпугивание зверя") 
        or ni.unit.debuff("target", "Ментальный крик") then
            cache.control = true
        else
            cache.control = false
        end
        if enables["debug"] then
            ni.vars.debug = true
        else
            ni.vars.debug = false
        end
    end,
    ------------------------
    ["pause"] = function()
        if IsMounted()
		or UnitInVehicle("player")
		or UnitIsDeadOrGhost("player")
		or UnitChannelInfo("player")
		or UnitCastingInfo("player")
		or ni.player.islooting()
        or not cache.sindra then
			return true;
		end
    end,
    -----------------------------------
    ["golpe_runa"] = function()
    if ni.unit.buff("player", 19263) or ni.unit.buff("player", 26669) then
        if ni.spell.available(spells.golpe_runa) then
            ni.spell.cast(spells.golpe_runa)
            end
        end
    end,			
	 --------------------------
    ["auto-target"] = function()
        local target_ = ni.objects["target"];
        local target__ = target_.guid
        if enables["target"]
        and cache.PlayerCombat then
            if target__ == 0 then
                ni.player.runtext("/startattack")
            end
            if ni.objectmanager.contains("Король-лич") then
                local lich = ni.objectmanager.objectGUID("Король-лич")
                local spell, _, _, _, _, endTime = UnitChannelInfo(lich)
                if spell == ("Беспощадность зимы") then
                    ni.player.runtext("/petfollow")
                elseif cache.pet == true then
                    ni.player.runtext("/petattack")
                    cache.pet = false
                end
            elseif cache.control then
                ni.player.runtext("/petfollow")
            elseif cache.pet == true then
                ni.player.runtext("/petattack")
                cache.pet = false
            end
        end
    end,
    -----------------------------------
    ["kick"] = function()
        if enables["kick_3"] then
            if enables["kick"] then
                if enables["kick_2"] then
                    local enemies = ni.unit.enemiesinrange("player", 25)
                    for i = 1, #enemies do
                        local target = enemies[i].guid
                        if ni.unit.iscasting(target)
                        or ni.unit.ischanneling(target) then
                            local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(target)
                            if inputs.kiick == ""
                            or inputs.kiick == spell then
                                if ni.spell.available(spells.kick)
                            and interrupt == false
                            and ni.spell.valid(target, spells.kick, false, true, true) then
                                ni.spell.cast(spells.kick, target)
                            end
                            end
                        end
                    end 
                elseif ni.unit.iscasting("target")
                or ni.unit.ischanneling("target") then
                    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo("target")
                    if ni.spell.available(spells.kick)
                    and interrupt == false
                    and ni.spell.valid("target", spells.kick, false, true, true) then
                        ni.spell.cast(spells.kick)
                    end
                end
            end
        else
            if enables["kick"] then
                if enables["kick_2"] then
                    local enemies = ni.unit.enemiesinrange("player", 25)
                    for i = 1, #enemies do
                        local target = enemies[i].guid
                        if ni.unit.iscasting(target)
                        or ni.unit.ischanneling(target) then
                            local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo(target)
                            if ni.spell.available(spells.kick)
                            and interrupt == false
                            and ni.spell.valid(target, spells.kick, false, true, true) then
                                ni.spell.cast(spells.kick, target)
                            end
                        end
                    end 
                elseif ni.unit.iscasting("target")
                or ni.unit.ischanneling("target") then
                    local spell, rank, displayName, icon, startTime, endTime, isTradeSkill, castID, interrupt = UnitCastingInfo("target")
                    if ni.spell.available(spells.kick)
                    and interrupt == false
                    and ni.spell.valid("target", spells.kick, false, true, true) then
                        ni.spell.cast(spells.kick)
                    end
                end
            end
        end
    end,
    --------------------------



    ["cd"] = function()
        if cache.PlayerCombat then
            count = GetItemCount("Фрагмент души")
            if ni.spell.available(316466)
            and not ni.unit.buff("player", 316466) then
                if count > 1 
                or ni.unit.hp("target") < 10 then
                    ni.spell.cast(316466)
                end
            end
            if ni.spell.available(316419)
            and ni.power.currentraw("player") < 40 then
                ni.spell.cast(316419)
            end
            if ni.spell.available(316422) then
                ni.spell.cast(316422)
            end
            if ni.spell.available(316445) then
                ni.spell.cast(316445)
            end
            if ni.spell.available(316295) then
                ni.spell.cast(316295)
            end
            if ni.unit.buff("player", 316440)
            and cache.PlayerCombat
            and ni.player.hasitem(50085) then
                ni.player.useitem(50085)
            end
            if ni.player.slotcastable(10)
            and ni.player.slotcd(10) == 0 then
                ni.player.useinventoryitem(10)
            end
            if ni.player.slotcastable(14)
            and ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            if ni.player.slotcastable(14)
            and  ni.player.slotcd(14) == 0 then
                ni.player.useinventoryitem(14)
            end
            if ni.spell.available(319326) then
                ni.spell.cast(319326)
            end
            if ni.spell.available(316396)
            and ni.spell.valid("target", 316396, false, true, true) then
                ni.spell.cast(316396)
            end
        end
    end,
    --------------------------
    ["p_profana"] = function()
        if enables["presencias"]
        and not cache.PlayerCombat
        and not ni.player.buff(48265) then
            if ni.spell.available(spells.p_profana) then
                ni.spell.cast(spells.p_profana)
                cache.pet = true
            end
        end
    end,
    --------------------------
    ["save"] = function()
        if cache.PlayerCombat then
            if enables["entereza"]
            and ni.unit.hp("player") <= values.entereza then
                if ni.unit.ttd("player") < 3
                and ni.spell.available(spells.ni) then
                    ni.spell.cast(spells.ni)
                end
            end
            if enables["pacto_pet"]
            and ni.unit.hp("player") <= values.pacto_pet then
                local creator = ni.unit.creator("playerpet")
                if ni.unit.ttd("player") < 2
                and creator ~= nil
                and ni.spell.available(spells.pacto_pet) then
                    ni.spell.cast(spells.pacto_pet)
                end
            end
            local startTime, duration, enable = GetItemCooldown(36892)
            local startTime_, duration, enable = GetItemCooldown(36893)
            local startTime__, duration, enable = GetItemCooldown(36894)
            if enables["kamen"] then
                if startTime == 0
                and startTime_ == 0
                and startTime__ == 0 then
                    if ni.player.hasitem(36892)
                    or ni.player.hasitem(36893)
                    or ni.player.hasitem(36894) then
                        if ni.unit.hp("player") <= values.kamen then
                            if ni.unit.ttd("player") < 2 then
                                ni.player.useitem(36892)
                                ni.player.useitem(36893)
                                ni.player.useitem(36894)
                            end
                        end
                    end
                end
            end
        end
    end,
    --------------------------
    ["golpe_mortal"] = function()
        if ni.unit.hp("player") < values.kamen then
            -- Verificar si el objetivo tiene los dos debuffs
            if  ni.unit.debuff("target", 55078, "player")
            and ni.unit.debuff("target", 55078, "player") then
                if ni.spell.available(spells.golpe_mortal) and ni.spell.valid("target", spells.golpe_mortal, false, true, true) then
                    ni.spell.cast(spells.golpe_mortal, "target")
                end
            end
        end    
    end,
    --------------------------
    ["caparazon"] = function()
        if cache.PlayerCombat
        and enables["ik"]
        and ni.player.debuff("Llama de la Legión") then
            if ni.spell.available(spells.caparazon) then
                ni.spell.cast(spells.caparazon)
            end
        end
        if cache.PlayerCombat
        and enables["lana"]
        and ni.player.debuff("Enjambre de sombras") then
            if ni.spell.available(spells.caparazon) then
                ni.spell.cast(spells.caparazon)
            end
        end
    end,
    --------------------------
    [[["Frost_defensive"] = function()
        local hasTargetBuff = ni.unit.buffs("target", 51713, "player") or ni.unit.buffs("target", 46924, "player")
        local isUnderThreshold = ni.unit.hp("player") < values.kamen
        local isBuff48263Missing = not ni.player.buff(48263)
        local isPresenciaEscarchaAvailable = ni.spell.available(spells.presencia_escarcha)
    
        if (hasTargetBuff or isUnderThreshold) and isBuff48263Missing and isPresenciaEscarchaAvailable then
            ni.spell.cast(spells.presencia_escarcha)
        end
        if ni.unit.hp("player") > values.kamen and not ni.player.buff(48265) then 
            ni.spell.cast(spells.presencia_escarcha)
        end
    end,]],
    -------------------------
    ["pestilencia"] = function()
        if enables["pestilencia"]
        and not cache.control
        and cache.PlayerCombat
        and cache.dots == true
        and cache.dots_obnov then
            local offcd, oncd = ni.rune.bloodrunecd()
            if offcd == 2
            and ni.spell.available(spells.transfusion) then
                ni.spell.cast(spells.transfusion)
                cache.pet = true
            end
            if ni.spell.available(spells.pestilencia)
            and ni.spell.valid("target", spells.pestilencia, false, true, true) then
                ni.spell.cast(spells.pestilencia, "target")
                cache.pet = true
            end
        end
    end,
    --------------------------
    

    --------------------------

    ["pestilencia_aoe"] = function()
        if enables["pestilencia_aoe"]
        and not cache.control
        and cache.PlayerCombat
        and cache.dots == true then
            local enemies = ni.unit.enemiesinrange("player", 10)
            for i = 1, #enemies do
                local target = enemies[i].guid
                if ni.unit.hpraw(target) > 100000
                and not ni.unit.debuff(target, 55078, "player")
                or not ni.unit.debuff(target, 55095, "player") then
                    if ni.spell.available(spells.pestilencia)
                    and ni.spell.valid("target", spells.pestilencia, false, true, true) then
                    ni.spell.cast(spells.pestilencia, "target")
                    cache.pet = true
                    end
                end
            end
        end
    end,
    -----------------------------------
    ["buff"] = function()
        if enables["cuerno"]
        and not ni.player.buff(spells.cuerno)
        and ni.spell.available(spells.cuerno) then
            ni.spell.cast(spells.cuerno)
        end
        if enables["escudo_oseo"]
        and not ni.player.buff(spells.escudo_oseo)
        and ni.spell.available(spells.escudo_oseo) then
            ni.spell.cast(spells.escudo_oseo)
        end
        if enables["pet"] then
            local creator = ni.unit.creator("playerpet")
            if creator == nil
            and ni.spell.available(spells.pet) then
                ni.spell.cast(spells.pet)
            end
        end
    end,
    --------------------------
    ["cadenas"] = function()
        if cache.PlayerCombat
        and not cache.control
        and not ni.unit.debuff("target", 55095, "player")
        and ni.spell.valid("target", spells.cadenas, false, true, true)
        and ni.spell.available(spells.cadenas) then
            ni.spell.cast(spells.cadenas, "target")
            cache.pet = true
        end
    end,
    --------------------------
    ["golpe_peste"] = function()
        if not cache.control
        and cache.PlayerCombat
        and not ni.unit.debuff("target", 55078, "player")
        and ni.spell.valid("target", spells.golpe_peste, false, true, true)
        and ni.spell.available(spells.golpe_peste) then
            ni.spell.cast(spells.golpe_peste, "target")
            cache.pet = true
        end
    end,
    --------------------------
    ["golpe_sangriento"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.dots == true
        and ni.unit.buffremaining("player", 66803) < 1
        and ni.spell.valid("target", spells.golpe_sangriento, false, true, true)
        and ni.spell.available(spells.golpe_sangriento) then
            ni.spell.cast(spells.golpe_sangriento, "target")
            cache.pet = true
        end
    end,
    --------------------------
    ["golpe_plaga"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.dots == true
        and ni.unit.buffremaining("player", 304806) < 1
        and ni.spell.valid("target", spells.golpe_plaga, false, true, true)
        and ni.spell.available(spells.golpe_plaga) then
            ni.spell.cast(spells.golpe_plaga, "target")
            cache.pet = true
        end
    end,
    --------------------------
    ["char_rass"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.dots == true
        and ni.spell.available(spells.char_rass) then
            ni.spell.cast(spells.char_rass, "player")
            cache.pet = true
          end
    end,
    --------------------------
    ["lik_buf"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.dots == true
        and not ni.player.buff(304809)
        and ni.spell.valid("target", spells.lik, false, true, true)
        and ni.spell.available(spells.lik) then
            ni.spell.cast(spells.lik, "target")
            cache.pet = true
        end
    end,
    --------------------------
    ["gargola_Buffed"] = function()
        if cache.PlayerCombat
        and ni.unit.buff("player", 53365)
        and ni.unit.buff("player", 67773)
        and ni.unit.buff("player", 53365)
        and ni.spell.available(spells.lik) then
            ni.spell.cast(spells.gargola, "target")
        end
    end,

    --------------------------
    ["gargola"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.dots == true then
            if ni.unit.isboss("target")
            or ni.vars.combat.cd then
                if ni.spell.valid("target", spells.gargola, false, true, true)
                and ni.spell.available(spells.gargola) then
                    ni.spell.cast(spells.gargola, "target")
                    cache.pet = true
                end
            end
        end
    end,
    --------------------------
    ["potenciar_runas"] = function()
        if cache.PlayerCombat
        and not cache.control
        and cache.dots == true
        and ni.power.current("player") < 80 then
            if ni.unit.isboss("target")
            or ni.vars.combat.cd then
                if ni.spell.available(spells.potenciar_runas) then
                    ni.spell.cast(spells.potenciar_runas)
                    cache.pet = true
                end
            end
        end
    end,
    --------------------------
    --------------------------
    ["lik"] = function()
        if cache.PlayerCombat
        and not cache.control
        and ni.spell.valid("target", spells.lik, false, true, true)
        and ni.spell.available(spells.lik) then
            ni.spell.cast(spells.lik, "target")
            cache.pet = true
        end
    end,
    --------------------------
};
ni.bootstrap.profile("mate_test", queue, abilities, OnLoad, OnUnLoad);

