;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
Scriptname AmmoTweaks:Fragments:Terminals:TERM_at_ConfigDistributionAmmo Extends Terminal Hidden Const

;BEGIN FRAGMENT Fragment_Terminal_01
Function Fragment_Terminal_01(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditPercentage(pEditMessage, pGlobalVeryCommon)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_02
Function Fragment_Terminal_02(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditPercentage(pEditMessage, pGlobalCommon)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_03
Function Fragment_Terminal_03(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditPercentage(pEditMessage, pGlobalUnCommon)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_04
Function Fragment_Terminal_04(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditPercentage(pEditMessage, pGlobalRare)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_05
Function Fragment_Terminal_05(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditPercentage(pEditMessage, pGlobalVeryRare)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_Terminal_06
Function Fragment_Terminal_06(ObjectReference akTerminalRef)
;BEGIN CODE
pSharedDefs.Menu_EditPercentage(pEditMessage, pGlobalUltraRare)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

AmmoTweaks:SharedDefinitions Property pSharedDefs Auto Const Mandatory

GlobalVariable Property pGlobalVeryCommon Auto Const Mandatory

Message Property pEditMessage Auto Const Mandatory

GlobalVariable Property pGlobalCommon Auto Const Mandatory

GlobalVariable Property pGlobalUncommon Auto Const Mandatory

GlobalVariable Property pGlobalRare Auto Const Mandatory

GlobalVariable Property pGlobalVeryRare Auto Const Mandatory

GlobalVariable Property pGlobalUltraRare Auto Const Mandatory
