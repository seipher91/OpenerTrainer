# Changelog

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
