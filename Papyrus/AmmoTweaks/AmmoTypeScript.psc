scriptname AmmoTweaks:AmmoTypeScript extends ActiveMagicEffect
{handles ammo swapping, casings per shot/reload, sets the global condition rate}


Group AmmoSwapping
{Player ammo swapping}
	Ammo Property 					pThisAmmo = none				auto Const
	{ammo used by this mod}
	ObjectMod Property 				pNextAmmoType = none			auto Const
	{next ammo mod in the chain}
	Message Property 				pSwapSuccessMsg = none 			auto Const
	{message to show on successful init}
	int Property 					iMaxNPCAmmo = 0					auto Const
	{max ammo to give to NPCs when first equipping the weapon}
EndGroup

Group WeapCondition
{player weapon condition}
	float Property					fConditionMult = 		1.0		auto Const
	{condition loss per shot, subtract 0.05 for each related perk}
	int Property					iConditionPerk = 		0		auto Const
	{0=none, 1=GunNut, 2=Science!, 3=Blacksmith}
EndGroup

Group AmmoCasings
{player + npc casings}
	MiscObject Property 			pCasingItem = 			none 	auto Const
	{casing item for this ammo type}
	int Property 					iCasingsType = 			0 		auto Const
	{casing ejection type:  0=off, 1=on shoot, 2=on reload}
	
	int Property 					iCasingsMaxCount = 		0		auto const
	{max number of casings given per event}
	int Property 					iNPCCasingsMaxCount = 	0		auto const
	{max number of casings given to NPCs on equip}
	
	float Property					fCasingsChance = 		0.0		auto const
	{chance of casings being added}
	float Property 					fChanceAdd = 			0.0		auto hidden
	{value added to chance, based on Luck + Agility  *saved}
	
EndGroup

String Property sHudName = "X.YZmm Std" auto Const

AmmoTweaks:AmmoTweaksQuestScript Property pAmmoTweaksQuest	auto Const mandatory


string sFireEvent = 		"WeaponFire" 				Const
string sReloadEvent = 		"ReloadComplete" 			Const


;**** Events

;/ ammo type init /;
Event OnEffectStart(Actor akTarget, Actor akCaster)
	if akTarget == Game.GetPlayer()
		;/listen for the ammo swapping event
			start early so mashing the key doesn't break things/;
		RegisterForCustomEvent(pAmmoTweaksQuest, "PlayerSwapAmmoEvent")
		
		;/register animation events if casings are needed/;
		if iCasingsType > 0
			if iCasingsType == 1
				RegisterForAnimationEvent(akTarget, sFireEvent)
			elseif iCasingsType == 2
				RegisterForAnimationEvent(akTarget, sReloadEvent)
			endIf
			fChanceAdd = (akTarget.GetValue(pAmmoTweaksQuest.pDefsQuest.pAgiAV) + akTarget.GetValue(pAmmoTweaksQuest.pDefsQuest.pLukAV)) * 0.005
		endIf
		
		;/set the condition rate/;
		float fPercSub = pAmmoTweaksQuest.pDefsQuest.GetPerkPercentage(iConditionPerk)
		pAmmoTweaksQuest.pDefsQuest.pConditionMult.SetValue(fConditionMult - fPercSub)
		
		if !(pAmmoTweaksQuest.UpdateATWidget(sHudName))
			if pSwapSuccessMsg as bool
				pSwapSuccessMsg.Show()
			endIf
		endIf
	else
		;/npc: random chance to add casings if none are present/;
		if iCasingsType > 0
			if akTarget.GetItemCount(pCasingItem) < 1
				if utility.RandomFloat() < fCasingsChance
					int tempCCount = utility.RandomInt(0, iCasingsMaxCount)
					if tempCCount > 0
						akTarget.AddItem(pCasingItem, tempCCount)
					endIf
				endIf
			endIf
		endIf	
	endIf
EndEvent


;/ listens for weapon fire or reload events for casings /;
Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	if akSource == Game.GetPlayer() as ObjectReference
		if (asEventName == sFireEvent)
			if iCasingsType == 1
				if utility.RandomFloat() < (fCasingsChance + fChanceAdd)
					int tempCCount = utility.RandomInt(0, iCasingsMaxCount)
					if tempCCount > 0
						akSource.AddItem(pCasingItem, tempCCount, true)
					endIf
				endIf
			endIf
		elseif (asEventName == sReloadEvent)
			if iCasingsType == 2
				if utility.RandomFloat() < (fCasingsChance + fChanceAdd)
					int tempCCount = utility.RandomInt(0, iCasingsMaxCount)
					if tempCCount > 0
						akSource.AddItem(pCasingItem, tempCCount, true)
					endIf
				endIf
			endIf
		endIf
	else
		;/edge case: event called by NPC's weapon, unregister/;
		if iCasingsType == 1
			UnRegisterForAnimationEvent(akSource as Actor, sFireEvent)
		elseif iCasingsType == 2
			UnRegisterForAnimationEvent(akSource as Actor, sReloadEvent)
		endIf
	endIf
EndEvent




;**** Custom Events

;/ player ammo type swapping /;
Event AmmoTweaks:AmmoTweaksQuestScript.PlayerSwapAmmoEvent(AmmoTweaks:AmmoTweaksQuestScript akSender, Var[] args)
	if pNextAmmoType != none
		bool bUseAlt = args[0] as bool
		akSender.WeaponAttachMod(pNextAmmoType, none, akSender.pDefsQuest.pSwapFailedMsg, bUseAlt)
	endIf
EndEvent
