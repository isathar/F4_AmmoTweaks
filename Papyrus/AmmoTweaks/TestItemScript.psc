ScriptName AmmoTweaks:TestItemScript extends ActiveMagicEffect
{hud tester}

HUDFramework hud

Event OnEffectStart(Actor akTarget, Actor akCaster)
	hud = HUDFramework.GetInstance()
	hud.RegisterWidget(Self, "ATHUD.swf", afX = 1072.0, afY = 584.0, abLoadNow = True, abAutoLoad = True)
	
EndEvent

Function HUD_WidgetLoaded(string asWidget)
	if asWidget == "ATHUD.swf"
		debug.notification("ATHUD.swf added")
		hud.SendMessageString("ATHUD.swf", "7", "9.99mm", abReplaceExisting = False)
	endIf
EndFunction
