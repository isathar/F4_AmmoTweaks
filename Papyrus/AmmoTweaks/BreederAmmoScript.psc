scriptname AmmoTweaks:BreederAmmoScript extends ActiveMagicEffect
{fusion breeder/recharger ammo script}


Ammo Property pBreederAmmo auto Const mandatory
int Property iAmmoMax = 15 auto Const

int iTimerIndex = 2 Const
float fTimerTime = 5.0 Const

;**** Events

;/ init /;
Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		int iTmpCount = akTarget.GetItemCount(pBreederAmmo) 
		if iTmpCount > iAmmoMax
			akTarget.RemoveItem(pBreederAmmo, iTmpCount, false)
			akTarget.AddItem(pBreederAmmo, iAmmoMax, false)
		endIf
		StartTimer(fTimerTime, iTimerIndex)
	endIf
EndEvent

;/ cleanup - doesn't fire all the time /;
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		CancelTimer(iTimerIndex)
	endIf
EndEvent

;/ add ammo item when timer fires /;
Event OnTimer(int aiTimerID)
	if aiTimerID == iTimerIndex
		Actor PlayerActor = Game.GetPlayer()
		if PlayerActor.GetItemCount(pBreederAmmo) < iAmmoMax
			PlayerActor.AddItem(pBreederAmmo, 1, false)
		endIf
		StartTimer(fTimerTime, iTimerIndex)
	endIf
EndEvent
