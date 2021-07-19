scriptname AmmoTweaks:WeaponConditionScript extends ActiveMagicEffect
{handles weapon condition changes}


;**** Properties

Group WeapCondition
{player weapon condition}
	ObjectMod Property				pWorseConditionMod = none		auto Const
	Message Property 				pWorseconditionMsg = none		auto const
	
	ObjectMod Property				pBetterConditionMod = none		auto Const
	Message Property				pBetterConditionMsg = none		auto Const
EndGroup


;**** Events

;/ init /;
Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		AmmoTweaks:AmmoTweaksQuestScript AmmoTweaksQuest = AmmoTweaks:AmmoTweaksQuestScript.GetScript()
		if AmmoTweaksQuest as bool
			RegisterForCustomEvent(AmmoTweaksQuest, "PlayerFieldRepairEvent")
		endIf
	endIf
EndEvent

;/ cleanup - doesn't fire all the time /;
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		UnregisterForAllCustomEvents()
	endIf
EndEvent


;**** Custom Event

;/ raise/lower weapon condition /;
Event AmmoTweaks:AmmoTweaksQuestScript.PlayerFieldRepairEvent(AmmoTweaks:AmmoTweaksQuestScript akSender, Var[] args)
	int repairAmount = args[0] as int
	if repairAmount > 0
		if pBetterConditionMod as bool
			akSender.WeaponAttachMod(pBetterConditionMod, pBetterConditionMsg, none, true)
		else
			Potion tempItem = args[1] as Potion
			if tempItem as bool
				(Game.GetPlayer()).AddItem(tempItem, 1, true)
			endIf
		endIf
	elseif repairAmount < 0
		if pWorseConditionMod as bool
			akSender.WeaponAttachMod(pWorseConditionMod, pWorseconditionMsg, none, false)
		endIf
	endIf
EndEvent
