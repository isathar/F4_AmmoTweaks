scriptname AmmoTweaks:SwitchAmmoTypeAltScript extends ActiveMagicEffect
{[Swap Ammo Alt] item effect: begins the alternateammo type swapping process }


Potion Property 							pAmmoSwapItem 		auto Const mandatory
{ammo swap item to return on use}
AmmoTweaks:AmmoTweaksQuestScript Property 	pAmmoTweaksQuest	auto Const mandatory


Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akCaster == Game.GetPlayer()
		if !Game.IsVATSPlaybackActive()
			;/ fire custom event to start ammo swap /;
			pAmmoTweaksQuest.PlayerSwapAmmo_Alt()
		endIf
		akCaster.AddItem(pAmmoSwapItem, 1, true)
	endIf
EndEvent
