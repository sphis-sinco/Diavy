# r4 (8/?/2025)
## Other
- Overwrote the original dummy game with the full game. (Base mod)
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