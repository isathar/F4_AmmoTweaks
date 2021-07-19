scriptname AmmoTweaks:SwitchAmmoTypeScript extends ActiveMagicEffect
{[Swap Ammo] item effect: begins the ammo type swapping process}


Potion Property 							pAmmoSwapItem 		auto Const mandatory
{ammo swap item to return on use}
AmmoTweaks:AmmoTweaksQuestScript Property 	pAmmoTweaksQuest	auto Const mandatory


Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akCaster == Game.GetPlayer()
		if !Game.IsVATSPlaybackActive()
			;/ fire custom event to start ammo swap /;
			pAmmoTweaksQuest.PlayerSwapAmmo()
		endIf
		akCaster.AddItem(pAmmoSwapItem, 1, true)
	endIf
EndEvent
