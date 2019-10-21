# Godot Wild Jam #14

## Theme

![Shadows](https://img.itch.zone/aW1nLzI1NzQ4MDEucG5n/original/LzPSsd.png)

## Debug

To activate debug mode: 
1. Open `scenes/main.tscn`
2. Set debug variable in the properties to true (checked)

In your code, you can check for debug status with: `Utils.is_debug()`

## Directory structure

* addons: Every used addons, this game requires Ink to handle scripted events
* assets: sounds, fonts, textures and so on
* build: Project exports goes there
* dialogs: Every scripted events goes here. One subdirectory per level please!
* docs: Useful documents related to the project, not required for the game to work
* entities: Entities that can be placed in any level
* environments: Custom environments goes there, every level can define one custom environments (TODO: Maybe add one more for shadow realm?)
* levels: Every level inheriting Level.tscn goes here. Add them to Game.tscn level array so they can be played
* nodes: Generic project nodes here, documentation about that follows, keep reading
* scenes: Main screens of the game. Typically, title screen, game screen, settings, ... main.tscn is the entry point
* screenshots: This may go into assets? Screenshots used for advertising the game
* scripts: General usage scripts. Currently contains Utils which is a singleton pre-loaded in project setting that can be used to access every game element from anywhere

## nodes

### Camera

Standalone camera for the game, used in the main scene.


### Character

Base scene for every NPC in the game and the Player. Contains speech bubble and choices features

Customize by inheriting that scene and extend: Character.gd

Customizable callbacks:
* same as interactable

### Dialog

Every scene that posses this can load an Ink script and process it. Highly coupled with game logic


### Interactable

Base scene for every highlitable elements. Allows to give them a context menu and custom behavior for actions of that context menu

Customize by inheriting that scene and extend: Interactable.gd

Customizable callbacks:
* _on_talk: Must return true for the action to be performed
* _on_examine: Must return true for the action to be performed
* _on_use
* _on_take: Must return true for the action to be performed
* _on_combination: When an item from inventory is used on this. Return true to consume inventory item


### Item

Base scene for every object in the game. Main difference with Character being they don't have speech features

Customize by inheriting that scene and extend: Item.gd

Customizable callbacks:
* same as interactable


### Level

Base scene for every level in the game.

Customize by inheriting that scene and extend: Level.gd

Customizable callbacks:
* on_start: called when the level is loaded


### Player

Can be moved and must be in the Level tree for most of the game logic to happen


### Trigger

Base scene for every invisble elements that should trigger given action under given conditions

Example: OneShotTrigger triggers a script when the Player pass through it

Customize by inheriting that scene and extend: Trigger.gd

Customizable callbacks:
* on_triggered: Response to trigger event

### UI

The two button ressource at the root are used for the title screen and ce be reused for any other button too

### UI/ActionButton

Generic action button, used in the context menu. Better used with no label and a small icon

### UI/ChoiceBubble

Choice UI used by the player (every character has it but it is not exploited/will not be exploited yet)

### UI/ContextMenu

Contain all possible context menu

### UI/Inventory

Manage the player's inventory

### UI/TextDisplay

Generic display of any text on multiline Label

### UI/TextDisplay/PopUp

Used for general display of text. Used in Game scene

### UI/TextDisplay/SpeechBubble

Used for Characters to talk

