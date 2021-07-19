scriptname AmmoTweaks:WeaponRepairKitScript extends ActiveMagicEffect
{Weapon Repair Kit item effect: increases current weapon's condition by nRepairAmount steps}


int Property 						nRepairAmount = 1 		auto Const 
{fraction of weapon condition to repair}
Potion Property 					pReturnItem 			auto Const mandatory
{item to return on failure}


Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		AmmoTweaks:AmmoTweaksQuestScript AmmoTweaksQuest = AmmoTweaks:AmmoTweaksQuestScript.GetScript()
		if AmmoTweaksQuest as bool
			AmmoTweaksQuest.PlayerFieldRepairWeapon(nRepairAmount, pReturnItem)
		endIf
	endIf
EndEvent
