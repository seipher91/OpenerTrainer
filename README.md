# OpenerTrainer

<img src="Media/logo.png" alt="OpenerTrainer logo" width="128" align="right"/>

**Practice your opener rotation until it's muscle memory.**

OpenerTrainer is a World of Warcraft addon (Midnight, 12.1) that shows your opener as an on-screen checklist: each spell turns green the moment you cast it, with the time delta between casts, so you can see exactly where your execution drifts from the plan.

## Features

- **Spell checklist tracker** — ordered list of your opener; entries turn green on a successful cast, with timing deltas between steps.
- **Compact icon bar** — a movable, icon-only bar you can place above your action bars: green border = done, yellow = current step, desaturated = pending.
- **Every class, every spec** — define as many named openers per specialization as you want.
- **69 built-in presets** — Season 2 (12.1) openers for all tank and DPS specs, sourced from Icy Veins, Maxroll and Method guides, complete with recommended talent strings.
- **Talent loadout import** — one click imports and activates an opener's recommended talent string as a named in-game loadout.
- **Share openers** — export/import via compact alphanumeric strings (talents included); importing never errors on spells that no longer exist.
- **Untalented spell warning** — steps whose talent isn't selected are shown in red.
- **Info steps** — non-castable reminders like "Pot + Items" that the tracker skips automatically.
- **Auto-reset out of combat**, minimap button, drag & drop editor, localized (English / Italiano).

## Installation

**CurseForge (recommended):** search for *OpenerTrainer* in the CurseForge app.

**Manual:** download the latest release and extract it so you have:

```
World of Warcraft/_retail_/Interface/AddOns/OpenerTrainer/
├── OpenerTrainer.toc
├── OpenerTrainer.lua
├── Presets.lua
└── Media/
```

## Usage

| Command | Effect |
|---|---|
| `/opener` (or `/opt`) | toggle the tracker window |
| `/opener edit` | open the opener editor |
| `/opener bar` | toggle the icon bar |
| `/opener reset` | reset the current run |
| `/opener autoreset` | toggle auto-reset on leaving combat |
| `/opener show` / `hide` | show / hide the tracker |
| `/opener status` | print current state |

Minimap button: **left-click** toggles the windows, **shift-click** toggles the bar only, **right-click** opens the editor.

In the editor, pick a preset (▼), drag spells from the searchable list into your opener, reorder steps by dragging, and use the talent button to activate the recommended loadout.

## Export format

Openers are shared as strictly alphanumeric strings (`V1` + hex-encoded name, optional talent string, and the step list), safe to paste anywhere. Importing skips spells that don't exist in the current game build instead of failing.

## License

[MIT](LICENSE) — © 2026 Seipher91
