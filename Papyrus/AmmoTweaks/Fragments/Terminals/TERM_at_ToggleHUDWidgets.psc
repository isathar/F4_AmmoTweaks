;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AmmoTweaks:Fragments:Terminals:TERM_at_ToggleHUDWidgets Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
pATQuest.ToggleHudWidgets(True)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
pATQuest.ToggleHudWidgets(False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

AmmoTweaks:AmmoTweaksQuestScript Property pATQuest auto Const mandatory
