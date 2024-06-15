do
    AddCSLuaFile("pvpm_config.lua")
    player_models_list = {}
    addons_id_list = {} 

    function loadPlayerModel(pm)
        assert(pm.player_model ~= nil, "Player model name is nil")
        assert(pm.player_model ~= "", "Player model name is empty")
        assert(pm.name ~= nil, "Player model name is nil")
        assert(pm.name ~= "", "Player model name is empty")

        print("  [Project Visualis - PM] Loading "..pm.name.." ("..pm.player_model..") ["..pm.addons_id.."]")
        player_manager.AddValidModel( pm.name, pm.player_model )
        list.Set( "PlayerOptionsModel", pm.name, pm.player_model )
        player_models_list[pm.name] = pm

        if(pm.has_custom_hands) then
            assert(pm.hands_info.model ~= nil, "Hands model name is nil")
            assert(pm.hands_info.model ~= "", "Hands model name is empty")
            print("    [Project Visualis - PM] Loading model arms... ("..pm.hands_info.model..")")
            s = pm.hands_info.skinid or 0
            b = pm.hands_info.bodygroup or "000000"
            mbs = pm.hands_info.matchBodyskin or false
            player_manager.AddValidHands( pm.name, pm.hands_info.model, s, b, mbs )
        end

        assert(pm.addons_id ~= nil, "Addons ID is nil")
        assert(pm.addons_id ~= "", "Addons ID is empty")
        addons_id_list[pm.addons_id] = true

        if ix and ix.anim then
            ix.anim.SetModelClass(pm.player_model, "player")
        end
    end

    print("\n[Project Visualis - PM] : Content addons by Lucasgood, Helped by Takeus.")
    print("[Project Visualis - PM] Loading models...")
    include("pvpm_config.lua")
    print("  [Project Visualis PM] found " .. #config.pm_list .. " playermodels to load")
    for k,pm in ipairs(config.pm_list) do 
        pcall(function () loadPlayerModel(pm) end) end
    print("[Project Visualis - PM] models loaded. Done !")
end