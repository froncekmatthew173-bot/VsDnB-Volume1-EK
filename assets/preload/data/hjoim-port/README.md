# Hjoim port status

The converted charts and metadata are in the engine's normal song registry at `assets/preload/data/songs/`; audio is in `assets/songs/`. The converted character JSON and Haxe classes use the normal character registry. Stage metadata and Haxe stage classes are in the normal stage registry. `convert-hjoim.ps1` regenerates the converted files.

There are 25 converted charts with 30,181 notes across 23 song IDs. Psych note times, sustains, lane ownership, note types, BPM changes, and key counts are retained. Hjoim has 6-key and 7-key charts. This engine has a 7-key strum sizing preset, so those chart counts are represented.

Countdown sounds are under `assets/preload/sounds/countdown/` and connected to matching character definitions. Song audio is under `assets/songs/`. Original graphics, fonts, sounds, shaders, videos, weeks, charts, custom events, and Lua scripts are preserved under the `hjoim-port` asset folders.

Stage Haxe classes now create static sprites and translate source positions, fixed angles, and scroll factors. Animated stage sprites, shaders, and per-frame Lua effects remain marked TODO. Song, global, and HUD Haxe module files are scaffolds that preserve callback names; Lua APIs and behavior still need manual Haxe translation. This engine has no custom note-type or custom-event registry, so those source files are preserved but do not execute.

Six character definitions refer to sprite sheets absent from the source folder: `bambineutral`, `bfHand`, `GF_assets`, `hjoimnew`, `opposition-expunged`, and `theoriginguy`. The related definitions remain present, but those characters cannot render until their sheets are supplied.
