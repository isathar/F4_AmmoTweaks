scriptname AmmoTweaks:MeleeHitEffectScript extends ActiveMagicEffect
{alters player weapon condition on melee hit/weapon bash}

AmmoTweaks:AmmoTweaksQuestScript Property 	pAmmoTweaksQuest	auto Const mandatory

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akCaster == Game.GetPlayer()
		pAmmoTweaksQuest.SubWeaponCondition()
	endIf
EndEvent
