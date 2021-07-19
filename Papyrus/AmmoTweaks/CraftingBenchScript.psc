scriptname AmmoTweaks:CraftingBenchScript extends ObjectReference
{modifies standard XP gain while in use}


Perk Property pXPModPerk auto Const mandatory


Event OnActivate(ObjectReference akActionRef)
	Actor PlayerActor = Game.GetPlayer()
	if akActionRef == PlayerActor as ObjectReference
		if !(PlayerActor.HasPerk(pXPModPerk))
			PlayerActor.AddPerk(pXPModPerk)
		endIf
		RegisterForMenuOpenCloseEvent("CookingMenu")
	endIf
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	if !abOpening
		Actor PlayerActor = Game.GetPlayer()
		if PlayerActor.HasPerk(pXPModPerk)
			PlayerActor.RemovePerk(pXPModPerk)
		endIf
		UnregisterForMenuOpenCloseEvent("CookingMenu")
	endIf
EndEvent
