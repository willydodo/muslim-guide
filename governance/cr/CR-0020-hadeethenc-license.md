# CR-0020 — HadeethEnc License

**Status:** APPROVED
**Date:** 2026-10-17

**Decision:** Use HadeethEnc.com as the source for azkar content (Phase 05b).

**License (verbatim from `HadeethEnc.com-API-v1.postman_collection_new.json`):**
- "Contents of the project can be used, with the following terms and conditions:"
- "1. No modification, addition, or deletion of the content."
- "2. Clearly referring to the publisher and the source (HadeethEnc.com)."

**Interpretation:**
- NoDerivs + Attribution (not MIT/CC0/CC-BY).
- Arabic text stored verbatim (no normalization, no silent NFC/NFD).
- `repeat` / virtue layer kept outside the verbatim text (separate metadata, gaps recorded not invented).
- English translation taken only from the API `en` field (no self-translation).
- Terms snapshot saved in `legal/evidence/` with sha256 before any import.

**Consequences:**
- `legal/assets.yaml` entry `hadith-hadeethenc` (SOURCE_IDENTIFIED).
- Every item carries `hadeethenc_id` + `grade` + `attribution` as returned.
- Any item without a verified ID is rejected from the pack.

**Approved By:** Abdo
