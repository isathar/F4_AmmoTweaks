ScriptName AmmoTweaks:ThrownWeapon_Reference extends ObjectReference

AmmoTweaks:AmmoTweaksQuestScript Property pAmmoTweaksQuest auto Const mandatory

Event OnEquipped(Actor akActor)
	if akActor == Game.GetPlayer()
		pAmmoTweaksQuest.pCurrentWeapon = self as ObjectReference
	endIf
EndEvent
