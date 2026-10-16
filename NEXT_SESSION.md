# NEXT SESSION — Phase 06 Task 2

> **Last updated:** 2026-10-16
> **Current phase:** Phase 06 — Task 2 (Quran Mushaf View)

## Project state

| Item | Value |
|---|---|
| Repository | `willydodo/muslim-guide` |
| HEAD | `9f6b001a3363488a54a27234ebcfcc50194a59cb` |
| CI | Passing on HEAD — [run 3](https://github.com/willydodo/muslim-guide/actions/runs/38943680092) |
| Approvals | APR-0001 and APR-0002 are APPROVED |
| Approval tags | `approval/phase-A-v1`, `approval/phase-B-v1` |
| Latest commit | `9f6b001` - `docs: update NEXT_SESSION for Phase 06 Task 2` |

## Completed phases and work

- Phases 00–04: complete.
- Phase 05 (Azkar skeleton): complete; content pack deferred.
- Phase 06 Task 1 (Quran data and font): complete.
  - `assets/content/quran/quran-uthmani.json`: 114 surahs, 6236 verses.
  - `assets/fonts/AmiriQuran.ttf`.
  - DEC-0030 selects JSON storage; OD-0003 is closed.
  - Tanzil asset remains `SOURCE_IDENTIFIED`, not `APPROVED`.
  - OD-0004 search normalization is deferred to Phase 12; Quran search is excluded from Phase 06.

## Current task: Phase 06 Task 2 — Mushaf View

### Scope

- Domain models: `Surah`, `Verse`, `QuranContent`.
- Quran repository and asset loader.
- Providers for Quran index and current surah.
- Screens: Quran index and surah reader.
- Widgets: surah list item, connected Mushaf text, verse tap handling, and verse actions sheet.
- Router paths: `/quran` and `/quran/surah/:id`.
- Localization keys for the Quran screens and actions.
- Focused unit/widget/integration tests.
- Device verification on the available Oppo reference device.

### Constraints

- Mushaf-style connected Quran text; tapping an ayah opens its actions sheet.
- No tafsir (Phase 06b), recitation (Phase 07), or search (Phase 12).
- Use Amiri Quran font.
- Quran text direction is always RTL.
- Never write Quran text to Hive.
- Preserve the source verse text exactly.
- Run `flutter analyze --fatal-infos` after each file change.
- Do not mark Tanzil `APPROVED` without the required human content/licensing review.

## References

- `phases/06.md` is not present yet; use `phases/README.md` and `NEXT_SESSION.md` until the phase specification is created.
- `docs/UI_VISION.md` §3, Quran recipe.
- `03-decisions.md` (DEC-0015 through DEC-0030).
- `04-open-decisions.md`.
- `approvals.yaml`.
- `assets/content/quran/quran-uthmani.json`.

## Protocol for the next session

1. Read this file and `docs/DIRECTOR_PLAYBOOK.md`.
2. Read `phases/README.md`, the Quran recipe in `docs/UI_VISION.md` §3, relevant decisions/open decisions, and AI development rules.
3. Verify current `HEAD`, approvals, tags, CI, and worktree state; do not rely on this snapshot if the repository has moved.
4. Present the five planning answers required by `docs/DIRECTOR_PLAYBOOK.md`: blocking open decisions, proposed files, required packages, first implementation steps, and verification approach.
5. Wait for Abdo's approval before changing code.

## Notes

- CI was verified passing for `9f6b001` on `main`.
- The active repository is `willydodo/muslim-guide`; no migration to another repository is needed.
- User-local files under `docs/_local/` are excluded from Git.
