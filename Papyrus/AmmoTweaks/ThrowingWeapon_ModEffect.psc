ScriptName AmmoTweaks:ThrowingWeapon_ModEffect extends ActiveMagicEffect
{handles new thrown weapon attachments}

Group WeaponType
	Weapon Property pWeaponForm = none auto Const
	{link to the thrown weapon form}
EndGroup

AmmoTweaks:AmmoTweaksQuestScript Property pAmmoTweaksQuest auto Const mandatory


;/ init weapon events /;
Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		utility.wait(1.0)
		if pWeaponForm != none
			RegisterForCustomEvent(pAmmoTweaksQuest, "PlayerSwapAmmoEvent")
			
			if akTarget.GetItemCount(pWeaponForm) > 0
				RegisterForAnimationEvent(akTarget, "WeaponSwing")
			else
				pAmmoTweaksQuest.UpdateThrownMod(akTarget, pWeaponForm)
			endIf
		else
			pAmmoTweaksQuest.UpdateThrownMod(akTarget, pWeaponForm)
		endIf
	endIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if akSource == Game.GetPlayer() as ObjectReference
		if asEventName == "WeaponSwing"
			Actor tempActor = akSource as Actor
			int iCurCount = akSource.GetItemCount(pWeaponForm)
			if iCurCount > 0
				pWeaponForm.Fire(akSource)
				if iCurCount == 1
					;/switch to next available mod/;
					pAmmoTweaksQuest.UpdateThrownMod(tempActor, pWeaponForm)
				endIf
			else
				pAmmoTweaksQuest.UpdateThrownMod(tempActor, pWeaponForm)
			endIf
		endIf
	endIf
EndEvent


;**** Custom Events

;/ player ammo type swapping /;
Event AmmoTweaks:AmmoTweaksQuestScript.PlayerSwapAmmoEvent(AmmoTweaks:AmmoTweaksQuestScript akSender, Var[] args)
	pAmmoTweaksQuest.UpdateThrownMod(Game.GetPlayer(), none)
EndEvent
