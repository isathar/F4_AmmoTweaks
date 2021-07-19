scriptname AmmoTweaks:Globals hidden


Function AT_SwapAmmo(bool bUseAltSwap = false) global
	AmmoTweaks:AmmoTweaksQuestScript ATQuest = Game.GetFormFromFile(9905, "AmmoTweaks_Core.esp") as AmmoTweaks:AmmoTweaksQuestScript
	if (ATQuest != none)
		ATQuest.SendPlayerSwapAmmoEvent(bUseAltSwap)
	endIf
EndFunction
