"""Shared helpers for core_v2 pack builders (Phase 07).

Rule: transcription only — findings come from Abdo's verified txt files;
no text from memory.
"""
import hashlib
import json
import re

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


def grade_simple_of(raw):
    """Derive a coarse grade from the literal degree string (no guessing).

    - starts with صحيح -> صحيح
    - starts with حسن -> حسن
    - starts with ضعيف -> ضعيف
    - starts with لم ينص / contains يتطلب مراجعة -> review_required
    - anything else -> unknown (kept, filtered in UI)
    """
    s = (raw or "").strip()
    if s.startswith("صحيح"):
        return "صحيح"
    if s.startswith("حسن"):
        return "حسن"
    if s.startswith("ضعيف"):
        return "ضعيف"
    for key, val in (("إسناده صحيح", "صحيح"), ("إسناده حسن", "حسن"),
                     ("إسناده حسن", "حسن"), ("صحح إسناده", "صحيح"),
                     ("حسن إسناده", "حسن"), ("صح ", "صحيح")):
        if key in s:
            return val
    if s.startswith("لم ينص") or "يتطلب مراجعة" in s:
        return "review_required"
    return "unknown"


def make_item(item_id, arabic, source, degree_raw, repeat, quran_ref,
              repeat_by_prayer=None, repeat_note=None):
    m = re.search(r"\((\d{3,5})\)", source or "")
    number = m.group(1) if m else None
    book, url = detect_book(source or "", number)
    item = {
        "id": item_id,
        "arabic": arabic,
        "translation_en": None,
        "source_ref": source,
        "source": {"book": book, "number": number, "sunnah_url": url},
        "degree_raw": degree_raw,
        "grade": degree_raw,
        "grade_simple": grade_simple_of(degree_raw),
        "repeat": repeat,
        "quran_ref": quran_ref,
        "review": {
            "status": "pending",
            "reviewer_id": "shaykh-1",
            "notes": "",
            "proposed_text": None,
            "edit_source": None,
            "decided_at": None,
        },
    }
    if repeat_by_prayer:
        item["repeat_by_prayer"] = repeat_by_prayer
    if repeat_note:
        item["repeat_note"] = repeat_note
    return item


def canonical(obj):
    return json.dumps(obj, ensure_ascii=False, sort_keys=True,
                      indent=2).encode("utf-8")


def build_pack(pack_id, category, items, source_file):
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
            "file": source_file,
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
