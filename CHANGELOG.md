# r7 (8/6/2025)
This is the release of 1.1 for base mod
- The to-be-continued now says the route you are on.
- The to-be-continued of the F.U. route now ends with the weird route jingle from Deltarune (base mod)
- Removed vase_crash .mp3 (base mod)
- Added `lastLoadedJSONPath` variable to `PlayState` that allows for scripts to read that and perform actions based on it's value
- Applied Adjust Color Shader to the F.U. route forest trip ending section (base mod)
- Added Adjust Color Shader: usable by scripts
- Changed text in the intro of the trip for the normal route to now more easily difference Miy's dialogue from Berin's (using 2 of the new dialogue entry fields) (base mod)
- Fixed Watermark outline
- Added `text_outline_color` field to dialogue entries (optional)
- Added `text_outline` field to dialogue entries (optional)
- Added `text_color` field to dialogue entries (optional)
- Added `text_speed` field to dialogue entries (optional)
- Edited the background in the last line of the Chapter 1 normal route (base mod)

# r6 (8/6/2025)
- Added watermark to gameplay that displays the game release number
- Added `frontLayer` to `PlayState` (modifyable by scripts if you want to make sure that something is on the main layer)

# r5 (8/6/2025)
- Removed `socials` field from the playtesters credit in the base mod
- Added Paul leps to the list of playtesters in the base mod credits.
- Added preference for `choiceTextSounds` (disabled by default, modifyable by scripts)
- Removed the version label from the `Project.xml` (Shouldn't keep it if I'm just going to forget about it)

# r4 (8/5/2025)
## Other
- Changed size of mod menu text
- Overwrote the original dummy game with chapter 1 of the full game. (Base mod)
- Added Caching State
- You can only have 1 mod enabled at once now
- Added sound: "light-switch" (Base mod)
- Added music track: "GM" (Base mod, this is from an old project. Sucks tho.)
## Events
- Added `playSound` event
- - arg: sfx (ex. "light-switch")
- Added `unpauseMusic` event
- Added `pauseMusic` event
- Added `stopMusic` event
- Added `startMusic` event
- - arg: track (ex. "GM")
- Added `cameraFlash` event
- - arg: color (ex. "0xFFFFFF")
## Dialogue Entries
- Added `flipped` field to dialogue entry fields `backgroundSettings` and `characterSettings` (optional)
- - field: x: Bool
- - field: y: Bool
- Added `script_events` field to dialogue entries (optional)
- Added `script_event` field to dialogue entries (optional)
- Added `wait` field to dialogue entries (optional)
## Script functions
- Added `addDialogueJsonPath` PlayState function for scripts
- Added `readDialogueJsonPath` PlayState function for scripts
- Added `addDialogueJson` PlayState function for scripts
- Added `readDialogueJson` PlayState function for scripts

# r3 (8/4/2025)
- More abstractions have been done.
- Enabled `defaultPersist` in `FlxGraphic` (This apparently Prevents all assets from being cleared from the cache when changing state)
- Also Fixed duplicate script classes (hopefully)
- Fixed dupe script paths
- You are now sent to the mod menu on startup
- Changed things using `FlxPoint` to use `{x, y}` so scripts can modify them
- Added an extra default line that says "You should probably add a mod or something."
- Moved the gameplay items to a mod so you can now toggle on and off the main game's content
- Fixed application version string
- Added Mod Menu

# r2 (8/4/2025)
- The choices Text no logner types the same text
- Added border to the choices text
- Added a background displayed behind the character
- - Added `background` field to the dialogue entry base (optional)
- - Added `backgroundSettings` field to the dialogue entry base (optional)
- - Added "sky" background
- Added characters displayed behind the dialogue box
- - Added `character` field to the dialogue entry base (optional)
- - Added `characterSettings` field to the dialogue entry base (optional)
- - Added "sphisSinco" character (ME!!!)
- - Added "sinco" character
- Removed Web build from Actions

# r1 (8/4/2025)
Featuring:
- Scripting
- Dialogue

And... yeah.

https://bsky.app/profile/sphis-sinco.bsky.social/post/3lvlmcjs2os2z