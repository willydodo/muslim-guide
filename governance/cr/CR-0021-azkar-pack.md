# CR-0021 — Azkar Pack (Phase 05 → 05b)

**Status:** APPROVED
**Date:** 2026-10-17

**Decision:** Expand Phase 05 (Skeleton) into Phase 05b (full Azkar Pack).

**Reason:**
- Phase 05 = skeleton ✅ (placeholders only, pending-pack Empty state).
- Pack was deferred `beyond-v1.0` for lack of a rights-clean source.
- HadeethEnc verified as source candidate (CR-0020, NoDerivs + Attribution).
- v1.0 needs real azkar content.

**Consequences:**
- Pack work happens under Phase 05b (does not rewrite Phase 05 history).
- Pilot (`morning`, HadeethEnc category 301) first, then 20 subcategories.
- Reviewer: shaykh-1 only (scope extended in `content/reviewers.yaml`).
- License: HadeethEnc (NoDerivs + Attribution).
- Schema: `content/08-review-workflow.md` (pack_id/version/checksum/approval).
- Every JSON starts `PENDING_REVIEW`; no `APPROVED` before human review + checksum.
- Loader/enum migration (DEC-0024/Stop 13) deferred until pilot review loop succeeds.

**Approved By:** Abdo
