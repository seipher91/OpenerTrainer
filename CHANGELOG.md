# Changelog

## 1.3.0 (2026-08-19)

### Added
- **Combo steps**: a step can now hold multiple spells meant to be pressed together (or nearly together), e.g. Reaper's Mark + Pillar of Frost. The step completes once all spells in the group are cast, in any order and with no strict time window — pressing them a GCD apart is fine. The current combo shows yellow progress (1/2), the recorded delta is measured to the first cast of the group, and the group's spread (how "together" you pressed them) is shown in parentheses. Tooltips list all members.
- **Editor**: right-click a sequence step to merge it with the next one into a combo; right-click a combo to split it back into single steps.
- Export/import format: combo members use the new `J` marker. Fully backward compatible — older versions ignore unknown markers and import the primary spell.

### Changed
- Frost Death Knight presets rebuilt as "12.1 - ST Deathbringer" and "12.1 - AoE Deathbringer" with combo steps: Empower Rune Weapon → Reaper's Mark + Pillar of Frost → Breath of Sindragosa + Raise Dead → Frostwyrm's Fury → Obliterate (ST) / Frostscythe (AoE) → Empower Rune Weapon.

## 1.2.4 (2026-08-18)

### Fixed
- Untalented detection: an unselected talent node now vetoes Blizzard's "known" APIs, which report unselected hero spell variants (e.g. Red Moon) as known and present in the spellbook. Only `IsPlayerSpell`/`C_SpellBook.IsSpellKnown` can override the veto, so baseline spells stay white.
- Talent map hardened against Secret Value spell names; build errors are printed to chat instead of failing silently.
- The editor SEQUENCE column now shows untalented steps in red (like tracker, bar and spell picker) and refreshes on talent changes while open.
- Applying a talent loadout no longer prints a spurious "(load)" error on the first click: the loadout save is asynchronous, activation now retries with backoff.

### Changed
- Guardian "12.1 - ST Elune's Chosen" preset: verified 12.1 talent string.
- New diagnostic command: `/opener spell <id>`.

## 1.2.3 (2026-08-18)

### Fixed
- Passive proc markers whose spell variant is not flagged passive (e.g. Reaver's Mark 442624 vs talent node 442679) are now detected by matching the names of passive talent nodes, and removed from imports and saved openers.
- Untalented detection now works for steps whose spellID is an unmapped variant of a talent node (e.g. Red Moon): if an unselected node shares the spell's name, the step is shown red.

### Changed
- Guardian Druid presets now include 12.1 talent strings (ST Druid of the Claw; AoE Elune's Chosen for the Elune preset) and the "12.1 - ST of Claw" preset was renamed to "12.1 - ST Druid of the Claw". Re-import the preset from the Presets menu to get the talents.

## 1.2.2 (2026-08-18)

### Added
- New addon icon and logo, shown next to the OpenerTrainer title in the editor header.
- **Resizable tracker**: drag the bottom-right grip to widen the window (250–620 px); width is saved per character.
- **Resizable editor**: drag the bottom-right grip up to 1500×950; the extra width is split across all three columns (20% openers sidebar, 30% spell list, 50% sequence) and the size is saved per character. New minimum 860×500 so the footer no longer overlaps.
- Truncated opener names show a cursor-anchored tooltip with the full name (tracker subtitle, opener dropdown, preset menu, editor sidebar).

### Fixed
- Passive spells (e.g. Inertia) are no longer accepted by opener imports — guide timelines include passive procs; they are skipped like unknown spells.
- One-time cleanup at login removes passive spells already present in saved openers.

### Meta
- TOC: author set to Seipher, added `X-Curse-Project-ID` and `X-Wago-ID`.

## 1.2.1 (2026-08-18)

- Initial public release: spell checklist tracker with timing deltas, icon bar, per-spec named openers, 69 built-in 12.1 presets with talent strings, talent loadout import, alphanumeric export/import, EN/IT localization.
