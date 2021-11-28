local WALK_SPEED = 4
local RUN_SPEED = 7

require("stategraphs/commonstates")

local actionhandlers =
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.GOHOME, "action"),
	ActionHandler(ACTIONS.PICK, "eat"),
	ActionHandler(ACTIONS.DRAWINGTRANSFERINV, "eat"),
}

local events=
{
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst) if not inst.components.health:IsDead() then inst.sg:GoToState("hit") end end),
    EventHandler("death", function(inst, data)
				inst.sg:GoToState("death", data)
			end),
    EventHandler("trapped", function(inst) inst.sg:GoToState("trapped") end),
    EventHandler("locomote",
        function(inst)
            if not inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("moving") then return end

            if not inst.components.locomotor:WantsToMoveForward() then
                if not inst.sg:HasStateTag("idle") then
                    if not inst.sg:HasStateTag("running") then
                        inst.sg:GoToState("idle")
                    end
                        inst.sg:GoToState("idle")
                end
            elseif inst.components.locomotor:WantsToRun() then
                if not inst.sg:HasStateTag("running") then
                    inst.sg:GoToState("run")
                end
            else
                if not inst.sg:HasStateTag("hopping") then
                    inst.sg:GoToState("hop")
                end
            end
        end),
    EventHandler("stunbomb", function(inst)
        inst.sg:GoToState("stunned")
    end),
}

local states=
{

    State{
        name = "look",
        tags = {"idle", "canrotate" },
        onenter = function(inst)
            if math.random() > .5 then
                inst.AnimState:PlayAnimation("lookup_pre")
                inst.AnimState:PushAnimation("lookup_loop", true)
                inst.sg.statemem.lookingup = true
            else
                inst.AnimState:PlayAnimation("lookdown_pre")
                inst.AnimState:PushAnimation("lookdown_loop", true)
            end
            inst.sg:SetTimeout(1 + math.random())
        end,

        ontimeout = function(inst)
            inst.sg.statemem.donelooking = true
            inst.AnimState:PlayAnimation(inst.sg.statemem.lookingup and "lookup_pst" or "lookdown_pst")
        end,

        events =
        {
            EventHandler("animover", function (inst, data)
                if inst.sg.statemem.donelooking then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    },

    State{

        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle", true)
            elseif not inst.AnimState:IsCurrentAnimation("idle") then
                inst.AnimState:PlayAnimation("idle", true)
            end
            inst.sg:SetTimeout(1 + math.random()*1)
        end,

        ontimeout= function(inst)
            inst.sg:GoToState("look")
        end,

    },

    State{

        name = "action",
        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle")
            inst:PerformBufferedAction()
        end,
        events=
        {
            EventHandler("animover", function (inst, data) inst.sg:GoToState("idle") end),
        }
    },

    State{
        name = "eat",

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("rabbit_eat_pre", false)
            inst.AnimState:PushAnimation("rabbit_eat_loop", true)
			
			if inst.bufferedaction and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.DRAWINGTRANSFERINV then
				inst.sg:SetTimeout(0.25)
			else
				inst.sg:SetTimeout(0.8)
			end
        end,

        ontimeout= function(inst)
            if inst.bufferedaction ~= nil and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.PICK then
				inst:PerformBufferedAction()
				local all_items = inst.components.inventory:ReferenceAllItems()
				local can_be_displayed_in_mouth_item = nil
				
				for i,v in ipairs(all_items) do
					if v ~= nil and v.prefab ~= nil and table.contains(TUNING.RABBIT_DRAWING_SUPPORTED_VEGGIES, v.prefab) then
						can_be_displayed_in_mouth_item = v
						break
					end
				end
				
				if inst.components.inventory and #(all_items) > 0 then
					if can_be_displayed_in_mouth_item then
						inst.HaveCarrot(inst, can_be_displayed_in_mouth_item)
					else
						inst.components.inventory:DropEverything()
						inst.RemoveCarrot(inst)
					end
				else
					if inst.components.hauntable then
						inst.components.hauntable:Panic(1.5)
					end
					inst.RemoveCarrot(inst)
				end
				inst.sg:GoToState("idle", "rabbit_eat_pst")
			
			elseif inst.bufferedaction ~= nil and inst.bufferedaction.action and inst.bufferedaction.action == ACTIONS.DRAWINGTRANSFERINV then
				if inst:HasTag("carrot_searching") then
					inst:RemoveTag("carrot_searching")
				end
				
				inst:PerformBufferedAction()
				inst.RemoveCarrot(inst)
				inst.sg:GoToState("idle", "rabbit_eat_pst")
			
			else
				inst.Physics:Stop()
				inst.AnimState:PlayAnimation("rabbit_eat_pre", false)
				inst.AnimState:PushAnimation("rabbit_eat_loop", true)
				inst.sg:SetTimeout(2+math.random()*4)
			end
        end,
    },

    State{
        name = "hop",
        tags = {"moving", "canrotate", "hopping"},

        timeline=
        {
            TimeEvent(5*FRAMES, function(inst)
                inst.Physics:Stop()
                inst.SoundEmitter:PlaySound("dontstarve/rabbit/hop")
            end ),
        },

        onenter = function(inst)
			if inst:HasTag("carrot_searching") then
				inst.AnimState:PlayAnimation("walk")
				inst.components.locomotor:WalkForward()
				inst.sg:SetTimeout(0.6)
			else
				inst.AnimState:PlayAnimation("walk")
				inst.components.locomotor:WalkForward()
				inst.sg:SetTimeout(2*math.random()+.5)
			end
        end,

        onupdate= function(inst)
            if not inst.components.locomotor:WantsToMoveForward() then
                inst.sg:GoToState("idle")
            end
        end,

        ontimeout= function(inst)
            inst.sg:GoToState("hop")
        end,
    },

    State{
        name = "run",
        tags = {"moving", "running", "canrotate"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("run_pre")
            inst.AnimState:PushAnimation("run", true)
            inst.components.locomotor:RunForward()
        end,
    },

    State{
        name = "death",
        tags = {"busy"},

        onenter = function(inst, data)
            inst.SoundEmitter:PlaySound(inst.sounds.scream)
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
            RemovePhysicsColliders(inst) 
			inst:DoTaskInTime(1, inst.Remove)
        end,

    },

     State{
        name = "fall",
        tags = {"busy", "stunned"},
        onenter = function(inst)
            inst.Physics:SetDamping(0)
            inst.Physics:SetMotorVel(0,-20+math.random()*10,0)
            inst.AnimState:PlayAnimation("stunned_loop", true)
        end,

        onupdate = function(inst)
            local pt = Point(inst.Transform:GetWorldPosition())
            if pt.y < 2 then
                inst.Physics:SetMotorVel(0,0,0)
            end

            if pt.y <= .1 then
                pt.y = 0

                inst.Physics:Stop()
                inst.Physics:SetDamping(5)
                inst.Physics:Teleport(pt.x,pt.y,pt.z)
                inst.DynamicShadow:Enable(true)
                inst.sg:GoToState("stunned")
            end
        end,

        onexit = function(inst)
            local pt = inst:GetPosition()
            pt.y = 0
            inst.Transform:SetPosition(pt:Get())
        end,
    },

    State{
        name = "stunned",
        tags = {"busy", "stunned"},

        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("stunned_loop", true)
            inst.sg:SetTimeout(GetRandomWithVariance(6, 2) )
            if inst.components.inventoryitem then
                inst.components.inventoryitem.canbepickedup = true
            end
        end,

        onexit = function(inst)
            if inst.components.inventoryitem then
                inst.components.inventoryitem.canbepickedup = false
            end
        end,

        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },

    State{
        name = "trapped",
        tags = {"busy", "trapped"},

        onenter = function(inst)
            inst.Physics:Stop()
			inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("stunned_loop", true)
            inst.sg:SetTimeout(1)
        end,

        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },
    State{
        name = "hit",
        tags = {"busy"},

        onenter = function(inst)
            inst.SoundEmitter:PlaySound(inst.sounds.hurt)
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        },
    },

}
CommonStates.AddSleepStates(states)
CommonStates.AddFrozenStates(states)


return StateGraph("rabbitdrawing", states, events, "idle", actionhandlers)

