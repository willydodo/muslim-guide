import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def main():
    pack_path = ROOT / "assets" / "content" / "tasbih" / "tasbih.json"
    dec_path = (ROOT / "content" / "reviews"
                / "decisions-tasbih-v1-2026-10-18.json")
    pack = json.loads(pack_path.read_text(encoding="utf-8"))
    dec = json.loads(dec_path.read_text(encoding="utf-8"))
    assert dec["checksum"] == pack["checksum"], (
        "decisions checksum %s != pack checksum %s"
        % (dec["checksum"], pack["checksum"])
    )
    by_id = {d["id"]: d for d in dec["decisions"]}
    assert len(by_id) == len(pack["items"]) == 6, "count mismatch"
    assert all(d["status"] == "approved" for d in by_id.values()), \
        "non-approved decision present"
    assert all(d.get("proposed_text") is None for d in by_id.values()), \
        "unexpected proposed_text"
    for it in pack["items"]:
        d = by_id[it["id"]]
        it["review"] = {
            "status": "approved",
            "reviewer_id": "shaykh-1",
            "notes": d.get("notes") or "",
            "proposed_text": None,
            "edit_source": None,
            "decided_at": d.get("decided_at"),
        }
    pack["status"] = "APPROVED"
    pack["reviewer"] = "shaykh-1"
    pack["reviewed_at"] = "2026-10-18"
    pack["approval"] = {
        "reviewer_id": "shaykh-1",
        "approved_at": "2026-10-18",
        "version_approved": pack.get("version"),
        "checksum_approved": pack["checksum"],
        "decisions_ref": "content/reviews/decisions-tasbih-v1-2026-10-18.json",
    }
    # checksum is content-only per 08-review-workflow (same method as the
    # morning merge): whitelist content keys, strip review bookkeeping.
    # tasbih has no proposed_text/edit_* fields (all approved, no edits),
    # so only "review" is stripped per item.
    content_keys = ("pack_id", "category", "version", "license", "source",
                    "items")
    content = {k: pack[k] for k in content_keys}
    content["items"] = [
        {k: v for k, v in it.items() if k != "review"}
        for it in pack["items"]
    ]
    import hashlib
    canon = json.dumps(content, ensure_ascii=False, sort_keys=True,
                       indent=2)
    sha = hashlib.sha256(canon.encode("utf-8")).hexdigest()
    pack["checksum"] = "sha256:" + sha
    pack["checksum_method"] = (
        "canonical-json-sha256-v1 content-only "
        "(excl. review/proposal/approval fields; UTF-8, sort_keys, indent=2)")
    pack_path.write_text(json.dumps(pack, ensure_ascii=False, sort_keys=True,
                                  indent=2) + "\n", encoding="utf-8")
    print("merged: 6 approved, checksum:", pack["checksum"])


if __name__ == "__main__":
    main()
