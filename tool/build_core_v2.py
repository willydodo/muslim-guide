"""Build core_v2 morning/evening packs from Abdo's verified 42-entry file.

Source: <repo>/أذكار المساء— أذكار الصباح.txt (21 morning + 21 evening)
Schema: content/08-review-workflow.md (pack_id/version/checksum/approval + review per item)
Rule: transcription only — no text from memory.
"""
import hashlib
import json
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "أذكار المساء— أذكار الصباح.txt"
OUT_DIR = ROOT / "assets" / "content" / "azkar" / "core_v2"

REPEAT_BY_PRAYER = {
    "morning_02": (3, 3, "3× بعد الفجر والمغرب"),
    "morning_03": (3, 3, "3× بعد الفجر والمغرب"),
    "morning_04": (3, 3, "3× بعد الفجر والمغرب"),
    "morning_20": (10, 10, "10× بعد الفجر والمغرب"),
    "evening_02": (3, 3, "3× بعد الفجر والمغرب"),
    "evening_03": (3, 3, "3× بعد الفجر والمغرب"),
    "evening_04": (3, 3, "3× بعد الفجر والمغرب"),
    "evening_20": (10, 10, "10× بعد الفجر والمغرب"),
}

BOOK_URLS = {
    "nasai": "nasai", "abudaud": "abudawud", "tirmidhi": "tirmidhi",
    "bukhari": "bukhari", "muslim": "muslim", "ibnmajah": "ibnmajah",
}


def detect_book(src, number):
    book = "other"
    if "البخاري" in src:
        book = "bukhari"
    elif "مسلم" in src:
        book = "muslim"
    elif "أبو داود" in src:
        book = "abudaud"
    elif "الترمذي" in src:
        book = "tirmidhi"
    elif "النسائي" in src or "الكبرى" in src:
        book = "nasai"
    elif "ابن ماجه" in src:
        book = "ibnmajah"
    elif "أحمد" in src or "المسند" in src:
        book = "ahmad"
    elif "الحاكم" in src:
        book = "hakim"
    elif "الطبراني" in src:
        book = "tabarani"
    elif "ابن السني" in src:
        book = "ibnalsunni"
    url = None
    slug = BOOK_URLS.get(book)
    if slug and number:
        url = "https://sunnah.com/%s:%s" % (slug, number)
    return book, url


def parse_block(block, prefix, idx):
    lines = [ln.strip() for ln in block.strip().splitlines() if ln.strip()]
    parts, source, degree, repeat, quran = [], "", "", 1, None
    for ln in lines:
        if ln.startswith("المصدر:"):
            source = ln[len("المصدر:"):].strip()
        elif ln.startswith("الدرجة:"):
            degree = ln[len("الدرجة:"):].strip()
        elif ln.startswith("التكرار:"):
            repeat = int(ln[len("التكرار:"):].strip())
        elif ln.startswith("مرجع قرآني:"):
            quran = ln[len("مرجع قرآني:"):].strip()
        else:
            parts.append(ln)
    m = re.search(r"\((\d{3,5})\)", source or "")
    number = m.group(1) if m else None
    book, url = detect_book(source or "", number)
    item_id = "%s_%02d" % (prefix, idx)
    item = {
        "id": item_id,
        "arabic": "\n".join(parts),
        "translation_en": None,
        "source_ref": source,
        "source": {"book": book, "number": number, "sunnah_url": url},
        "grade": degree,
        "repeat": repeat,
        "quran_ref": quran,
        "review": {
            "status": "pending",
            "reviewer_id": "shaykh-1",
            "notes": "",
            "proposed_text": None,
            "edit_source": None,
            "decided_at": None,
        },
    }
    if item_id in REPEAT_BY_PRAYER:
        fajr, maghrib, note = REPEAT_BY_PRAYER[item_id]
        item["repeat_by_prayer"] = {"fajr": fajr, "maghrib": maghrib}
        item["repeat_note"] = note
    return item


def canonical(obj):
    return json.dumps(obj, ensure_ascii=False, sort_keys=True, indent=2).encode("utf-8")


def build_pack(pack_id, category, items):
    pack = {
        "pack_id": pack_id,
        "version": "0.1.0",
        "category": category,
        "status": "PENDING_REVIEW",
        "reviewer": "shaykh-1",
        "reviewed_at": None,
        "license": "Kutub al-Sittah refs + Albani verification (reference only, no copy)",
        "source": {
            "name": "Abdo verified file",
            "file": "azkar-morning-evening-42.txt",
            "entries": len(items),
        },
        "items": items,
        "approval": {
            "reviewer_id": "shaykh-1",
            "approved_at": None,
            "version_approved": None,
            "checksum_approved": None,
        },
    }
    stripped = {
        k: v for k, v in pack.items()
        if k not in ("checksum", "checksum_method", "approval")
    }
    stripped["items"] = [
        {k: v for k, v in it.items() if k != "review"} for it in items
    ]
    digest = hashlib.sha256(canonical(stripped)).hexdigest()
    pack["checksum"] = "sha256:" + digest
    pack["checksum_method"] = "canonical-json-sha256-v1 content-only"
    return pack


def main():
    raw = SRC.read_text(encoding="utf-8")
    secs = re.split(r"الفئة:\s*evening", raw)
    if len(secs) != 2:
        sys.exit("expected morning + evening sections")
    m_raw, e_raw = secs
    m_blocks = [b for b in re.split(r"(?m)^الذكر\s+\d+\s*$", m_raw)
                if b.strip() and "الفئة" not in b[:60]]
    e_blocks = [b for b in re.split(r"(?m)^الذكر\s+\d+\s*$", e_raw)
                if b.strip() and "أذكار المساء" not in b[:60]]
    assert len(m_blocks) == 21, "morning=%d" % len(m_blocks)
    assert len(e_blocks) == 21, "evening=%d" % len(e_blocks)
    morning = [parse_block(b, "morning", i + 1) for i, b in enumerate(m_blocks)]
    evening = [parse_block(b, "evening", i + 1) for i, b in enumerate(e_blocks)]
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    mp = build_pack("morning-v2", "core", morning)
    ep = build_pack("evening-v2", "core", evening)
    (OUT_DIR / "morning.json").write_text(
        json.dumps(mp, ensure_ascii=False, sort_keys=True, indent=2) + "\n",
        encoding="utf-8")
    (OUT_DIR / "evening.json").write_text(
        json.dumps(ep, ensure_ascii=False, sort_keys=True, indent=2) + "\n",
        encoding="utf-8")
    print("morning: %d items, %s" % (len(morning), mp["checksum"]))
    print("evening: %d items, %s" % (len(evening), ep["checksum"]))
    print("grades morning:", sorted({i["grade"] for i in morning}))
    print("grades evening:", sorted({i["grade"] for i in evening}))


if __name__ == "__main__":
    main()
