require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.GOHOME, "action"),
    ActionHandler(ACTIONS.PICKUP, "action"),
    ActionHandler(ACTIONS.STEAL, "action"),
    ActionHandler(ACTIONS.HARVEST, "action"),
    ActionHandler(ACTIONS.ATTACK, "throw"),
    ActionHandler(ACTIONS.EAT, "eat"),
	ActionHandler(ACTIONS.PICK, function(inst, action)
		return action and action.target and action.target:HasTag("jostlepick") and "throw" or "action"
	end),
	ActionHandler(ACTIONS.CHOP, "throw"),
	ActionHandler(ACTIONS.MINE, "throw"),
	ActionHandler(ACTIONS.UNPIN, "action"),
	ActionHandler(ACTIONS.INTERACT_WITH, "action"),
	ActionHandler(ACTIONS.DRAWINGTRANSFERINV, "action"),
}

local events=
{
    CommonHandlers.OnLocomote(false, true),
    CommonHandlers.OnFreeze(),
    CommonHandlers.OnAttacked(),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnSleep(),
    EventHandler("doattack", function(inst, data)
        if not (inst.components.health:IsDead() or inst.sg:HasStateTag("busy")) then
            -- Sketch Monkey does not have a ranged attack - redirect all attack attempts to "attack" state
            inst.sg:GoToState("attack")
        end
    end),
}

local states =
{
    State{

        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle_loop", true)
            else
                inst.AnimState:PlayAnimation("idle_loop", true)
            end
            inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/idle")
        end,

        timeline =
        {

        },

        events=
        {
            EventHandler("animover", function(inst)

                if inst.components.combat.target and
                    inst.components.combat.target:HasTag("player") then

                    if math.random() < 0.05 then
                        inst.sg:GoToState("taunt")
                        return
                    end
                end

                inst.sg:GoToState("idle")

            end),
        },
    },

    State{

        name = "action",
		
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("interact", true)
            inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
        end,
		
        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
        end,
		
		timeline =
        {
            TimeEvent(10*FRAMES, function(inst)
                if inst.bufferedaction and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.DRAWINGTRANSFERINV then
					inst:PerformBufferedAction()
					inst.sg:GoToState("idle")
				end
            end),
			
			TimeEvent(21*FRAMES, function(inst)
                if inst.bufferedaction and inst.prefab == "monkey_drawing" then
					inst:PerformBufferedAction()
				end
            end)
        },
		
        events=
        {
            EventHandler("animover", function (inst)
                inst:PerformBufferedAction()
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{

        name = "eat",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat", true)
        end,

        onexit = function(inst)
            inst:PerformBufferedAction()
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst)
                local waittime = FRAMES*8
                for i = 0, 3 do
                    inst:DoTaskInTime((i * waittime), function() inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/eat") end)
                end
            end)
        },

        events=
        {
            EventHandler("animover", function (inst)
                inst.sg:GoToState("idle")
            end),
        }
    },

    State{
        name = "taunt",
        tags = {"busy"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("taunt")
        end,

        timeline =
        {
            TimeEvent(8*FRAMES, function(inst)
                --12 fist hits
                inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/taunt")
                local waittime = FRAMES*2
                for i = 0, 11 do
                    inst:DoTaskInTime((i * waittime), function() inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/chest_pound") end)
                end
            end)
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },

    State{
        name = "throw",
        tags = {"attack", "busy", "canrotate", "throwing"},

        onenter = function(inst)
            if inst.components.locomotor then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("throw")
        end,

        timeline =
        {
            TimeEvent(14*FRAMES, function(inst) 
				if inst.bufferedaction then
					if inst.bufferedaction.action ~= nil and inst.bufferedaction.action == ACTIONS.MINE and inst.bufferedaction.target then
						local target = inst.bufferedaction.target ~= nil and inst.bufferedaction.target or nil
						local frozen = target ~= nil and inst.bufferedaction.target:HasTag("frozen")
						local moonglass = target ~= nil and target:HasTag("moonglass")
						if target ~= nil and target.Transform ~= nil then
							local pos_x, pos_y, pos_z = target.Transform:GetWorldPosition()
							local fx = SpawnPrefab(frozen and "mining_ice_fx" or "mining_fx")
							if fx ~= nil and fx:IsValid() and pos_x ~= nil then
								fx.Transform:SetPosition(pos_x, pos_y, pos_z)
							elseif fx ~= nil then
								fx:Remove()
							end
						end
						inst.SoundEmitter:PlaySound((frozen and "dontstarve_DLC001/common/iceboulder_hit") or (moonglass and "turnoftides/common/together/moon_glass/mine") or "dontstarve/wilson/use_pick_rock")
					else
						inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/throw")
					end
					inst:PerformBufferedAction()
				end
			end),
        },

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}

CommonStates.AddWalkStates(states,
{
    starttimeline =
    {

    },

	walktimeline =
    {
        TimeEvent(4*FRAMES, function(inst) PlayFootstep(inst) end),
        TimeEvent(5*FRAMES, function(inst) PlayFootstep(inst) end),
        TimeEvent(10*FRAMES, function(inst)
            PlayFootstep(inst)
            if math.random() < 0.1 then
                inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/idle")
            end
         end),
        TimeEvent(11*FRAMES, function(inst) PlayFootstep(inst) end),

	},

    endtimeline =
    {

    },
})


CommonStates.AddSleepStates(states,
{
    starttimeline =
    {

    },

    sleeptimeline =
    {
    TimeEvent(1*FRAMES, function(inst)
        inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/sleep") end),
    },

    endtimeline =
    {

    },
})

CommonStates.AddCombatStates(states,
{
    attacktimeline =
    {
        TimeEvent(17*FRAMES, function(inst)
            inst.components.combat:DoAttack()
            inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/attack")
        end),
    },

    hittimeline =
    {
    TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/hurt") end),
    },

    deathtimeline =
    {
        TimeEvent(1*FRAMES, function(inst)
            inst.SoundEmitter:PlaySound("dontstarve/creatures/monkey"..inst.soundtype.."/death") end),
    },
})

CommonStates.AddFrozenStates(states)


return StateGraph("monkey", states, events, "idle", actionhandlers)
