ScriptName AmmoTweaks:TestItemScript2 extends ActiveMagicEffect
{hud tester}

HUDFramework hud

Event OnEffectStart(Actor akTarget, Actor akCaster)
	hud = HUDFramework.GetInstance()
	hud.RegisterWidget(Self, "CNDHUD.swf", afX = 960.0, afY = 690.0, abLoadNow = True, abAutoLoad = True)
	
EndEvent

Function HUD_WidgetLoaded(string asWidget)
	if asWidget == "CNDHUD.swf"
		debug.notification("CNDHUD.swf added")
		hud.SendMessage("CNDHUD.swf", 8, 2)
	endIf
EndFunction
