# AmmoTweaks

A Fallout 4 Mod. Includes ammo switching, additional ammo types, a weapon condition system, ammo/explosives crafting, and more. 

-------------------------------------------------------------------------------------------------------

Also available on ModDB: https://www.moddb.com/mods/ammotweaks

-------------------------------------------------------------------------------------------------------

## Warnings
- This mod will be replaced by WeaponTweaks (no link yet) when it's ready and will not be receiving any more major updates.
- As of release 1.1, the master file is an esp to make it easier to upload it to Bethesda.net.
	- This means you'll need to remove any previous versions before installing this one.
- This mod uses a lot of scripts.
	- There is a script attached to each weapon reference, so your save file size will increase.
- Do not rename AmmoTweaks_Core.esp - it's referenced by name in some scripts and the configuration menu.
- Some ammo objects are included but not enabled. Their artwork and/or stats are unfinished, and they may be enabled on a future release.
    - they can't be found in the game for now.
    - unfinished types: .22LR, .44 Special and .38 Special subtypes, 5.45x39mm, Electrified and Exploding Harpoon Gun ammo


## Installation
- Download from the releases tab or bethesda.net, extract the esp and ba2 files to Fallout4\\Data\\
- Using a mod manager:
	- Enable AmmoTweaks_Core.esp for the core files/framework.
	- Enable AmmoTweaks_Default.esp OR AmmoTweaks_Default_NoDLCs.esp
		- optional default configuration and changes to the base game.
		- Use AmmoTweaks_Default_NoDLCs.esp if you don't have Automatron, Far Harbor, and Nuka-World installed.


## Usage 
- If starting a new game:
	- Setup prompts will appear once you've picked up the Pip-Boy (or advanced past that point in the quest for alternate start mods compatibility).
- If installed mid-game:
	- Setup prompts will appear when the game is loaded.
- If you have MCM installed, the [Swap Ammo] item and holotape are not needed.
	- Swapping ammo is bindable to a hotkey via MCM.
- If you choose not to automatically obtain (or lose) the [Swap Ammo] items and Configuration Holotape, new ones can be crafted at a Munitions Workbench.
- Assign the [Swap Ammo] item to a hotkey/quickslot.
- Using the [Swap Ammo] item will cycle your weapon to the next ammo type (regardless of the amount of corresponding ammo you have)
- the [Swap Ammo Alt] item is for unique weapons that refuse to work with the [Swap Ammo] item.
-------------------------------------------------------------------------------------------------------


## Features
-------------------------------------------------------------------------------------------------------
## Ammo/Attack Types
- Adds several new calibers and ammo variations and the ability to switch between them.
	- Calibers added: .223 Caliber, .338 Magnum, .357 Magnum, .45 LC, 9x19mm, .45-70 Caliber (replaced if Far Harbor is installed), 7.62x39mm (replaced if Nuka-World is installed), 7.62x51mm, 7mm (minigun), 20 Gauge shell, Institute Energy Cells
	- Each caliber has variations (such as AP, HP, JHP, etc) that can be swapped between at any time using the [Swap Ammo] consumable item.
	- Each caliber and variation has a corresponding amount of armor penetration.
- Melee weapons use the ammo swapping system to enable different attack types.
	- Attack Types: Swing, Thrust and Sweep.
-------------------------------------------------------------------------------------------------------
## Weapon Condition (optional)
- All ranged and melee weapons have 'health' and can break with use. 
- Weapon Workbenches can be used to repair them or improve them beyond 100%.
- Different ammo and attack types degrade weapons at different rates. 
	- Crafting perks also affect the amount of condition subtracted per shot. (-5% per rank of Gun Nut, Science!, or Blacksmith)
- When a weapon's condition reaches 0, it is automatically unequipped and cannot be re-equipped until it is repaired. 
	- An option to destroy them when broken exists in the holotape.
- Effects:
	- Ballistic weapons and launchers lose range and value, and gain recoil as they deteriorate.
	- Energy weapons lose damage, ammo capacity, range, and value, and gain recoil.
	- Melee weapons lose damage and value.
-------------------------------------------------------------------------------------------------------
## HUD Widget for Ammo Type and Condition (automatically enabled, can be toggled on/off)
- Requires HUDFramework by registrator2000, I've been able to add a hud display.
- This mod will automatically detect if HUDFramework is installed and switch from displaying things as messages to a condition bar/icon and a text display for Ammo Types if found.
- Condition can be displayed as either a bar or an icon that changes color.
- The bar is designed to fit with the style of the standard HUD.
-------------------------------------------------------------------------------------------------------
## Weapon SPECIAL Restrictions (optional)
- Larger weapons require Strength to equip, and energy weapons require Intelligence.
-------------------------------------------------------------------------------------------------------
## Projectile and Visual Tweaks
- Ballistic projectiles now have velocity and are influenced by gravity.
- Velocity is based on actual statistics derived from muzzle velocity and force (and converted to Fallout's units). 
	- Gravity is not, so bullet drop is probably not accurate.
- Projectiles use a performance-friendly glowing sprite when not in VATS.
- There are no tracers, but projectiles are still visible (just very fast and small in some cases).
- Added several resized muzzle flashes.
- Frag and missile explosions have a higher radius. Plasma and Pulse explosions create appropriately colored light.
- Mines and grenades can explode when damaged.
-------------------------------------------------------------------------------------------------------
## Ammo/Explosives Crafting
- An ammo crafting system using the standard crafting bench menus is included. 
- New components based on Fallout New vegas and research are used in all recipes.
- 3 new workbenches can be found in the workshop menu's Crafting category:
	- Reloading Bench - recipes for Ballistic ammo
	- Recharging Bench - recipes for Energy ammo
	- Explosives Workbench - recipes for Explosive ammo, mines and grenades.
- An option exists to alter or disable the amount of standard XP gained while crafting ammo. Standard crafting perk requirements can also be disabled using the configuration holotape.
- Different powders required for ammo and explosives can be crafted at Chemistry Stations. 
- Casings, drained cells and primers can not be crafted.
- Casings can be obtained by firing weapons or buying Ammo Boxes. 
- The chance to obtain casings per shot is affected by the ammo type, your Luck and Agility.
- Shipment items have also been added for the new components and can be distributed to vendor leveled lists.
-------------------------------------------------------------------------------------------------------
## Thrown Weapons (distribution can be disabled during initial setup)
- Added items: Dynamite Stick, Throwing Knife, Rock, Baseball, Flare
- Restored Far Harbor throwing weapons (requires DLC): Saw Blade, Harpoon, Electrified Harpoon, Explosive Harpoon, Switchblade
-------------------------------------------------------------------------------------------------------
## Unique Weapons for Followers
- Follower weapons have been tweaked to use standard ammunition and be usable by the player.
- Each follower's weapon has a unique name based on unique weapons from previous games and Fallout Shelter.
-------------------------------------------------------------------------------------------------------
## Robot, Vertibird and Turret Tweaks
- Turrets have been updated to use more ammo types and damage values for all mechanical characters' weapons have been boosted.
- The holotape/MCM includes settings to boost the damage resistance values of Mechanical enemies, Vertibirds, Deathclaws, and Power Armor. (compatible with everything, enabled by default).
-------------------------------------------------------------------------------------------------------
## Help Menu Entries
- Several entries have been added to the Help section in the Pause menu.
-------------------------------------------------------------------------------------------------------
## Edited Settings
- Changes have been made to the following GameSettings if using the Full plugin or the optional Settings plugin:
- descriptions are included in case you want to edit these.
	- *fGunShellLifetime* : 60.0
		- increases the amount of time it takes before an ejected shell casing is deleted.
		- can decrease performance if set to crazy levels, 60 seconds seemed rational.
	- *fProjectileMaxDistance* : 65536.0000 (default: 32768.0000)
		- the distance at which projectiles either stop affecting things or get deleted.
		- makes rifle ammo range more reasonable.
	- *iMaxAttachedArrows* : 8 (def 3)
		- allows more throwing weapons and railway spikes to stick out of enemies.
		- could affect performance if you overdo it with throwing weapons.
	- *iProjectileMaxRefCount* : 32 (default 15)
		- I'm not sure about this one, but it seems to affect the amount of visible projectiles.
		- There's probably more going on in the background.
		- It doesn't seem to affect performance much, if at all, so I'm keeping it on :)
-------------------------------------------------------------------------------------------------------
## Optional Enhancements
- The HUD widget for displaying ammo type and weapon condition requires HUDFramework by registrator2000 (link).
	- AmmoTweaks can work without it, but I consider the widget essential.
- Can be configured with MCM (link).
-------------------------------------------------------------------------------------------------------


## Bugs
- Most unique (editor-placed) weapons won't allow swapping ammo types or changing condition mods in real time using the default *Swap Ammo* item.
    - Using the item named *Swap Ammo Alt* will allow swapping ammo/attack types for these weapons.
        - This alternate method has the drawback of sometimes picking one of your weapons of the same type at random if you have more than one weapon of the same type.
    - condition will update when these weapons are unequipped or equipped.
- The hud widget will sometimes display a weapon's condition as broken when it's not.
- The hud widget is positioned awkwardly when using power armor.
- The hud widget sometimes randomly disappears until the game is reloaded.


## Compatibility
- The core plugin (AmmoTweaks_Core.esp) does not modify any game data.
- The example plugins (AmmoTweaks_DefaultX.esp) modify:
	- all weapons that can be used by the player
	- all follower weapons
	- most turret and robot weapons
	- all ammo leveled lists used by vendors and loot
	- all "Ammo Conversion" receiver mods and their misc objects


-------------------------------------------------------------------------------------------------------
### Mod licensing info: (the software being Fallout 4) 
- *THIS MATERIAL IS NOT MADE, GUARANTEED OR SUPPORTED BY THE PUBLISHER OF THE SOFTWARE OR ITS AFFILIATES.*
- This mod includes modified versions of materials, meshes and textures created and owned by Bethesda Game Studios.
- Modders are welcome to use this mod as a framework or create mods depending on it.
- Mod pack creators are welcome to link to this mod.
