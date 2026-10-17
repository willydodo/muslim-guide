"""Phase 05c Task 2 — build tasbih pack from HadeethEnc (verbatim, no memory).

Mapping (Abdo-approved hadith numbers -> HadeethEnc IDs):
- 597 (33/33/34 after prayer)  -> 6259 (muslim 596 wording 33/33/34) + 10948
- 2691 (100x subhanallah wa bihamdihi) -> 5516
- 2693/2691 (100x tahlil) -> 65905 (muslim 2691 wording, 100x)
- 2702 (100x tawba) -> 4809
- 6384 (hawqala) -> 5477 (baqiyat salihat incl. hawqala) BUT grade is
  "صحيح بشواهده" and wording differs -> item kept as review_required
  per E-1 (no guessing).
"""
import json
import sys
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from core_v2_common import build_pack, make_item

UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}


def fetch(hid):
    req = urllib.request.Request(
        "https://hadeethenc.com/api/v1/hadeeths/one/?language=ar&id=" + hid,
        headers=UA)
    return json.loads(urllib.request.urlopen(req, timeout=30).read())


SPECS = [
    # (item_id, hadeethenc_id, repeat, dhikr_text_override, notes)
    ("subhanallah", "6259", 33, "سبحان الله", "33x after prayer"),
    ("alhamdulillah", "6259", 33, "الحمد لله", "33x after prayer"),
    ("allahuakbar", "6259", 34, "الله أكبر", "34x after prayer"),
    ("subhanallah_wa_bihamdihi", "5516", 100, None, "100x"),
    ("la_ilaha_illallah", "65905", 100, None, "100x"),
    ("astaghfirullah", "4809", 100, None, "100x tawba wording"),
    ("la_hawla_wa_la_quwwata", "5477", 100, "لا حول ولا قوة ولا قوة إلا بالله",
     "review_required: wording differs"),
]

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "assets" / "content" / "tasbih" / "tasbih.json"


def main():
    items = []
    for item_id, hid, repeat, ovr, _note in SPECS:
        d = fetch(hid)
        ref = "HadeethEnc %s | %s | %s" % (hid, d.get("attribution", ""),
                                           d.get("reference", ""))
        item = make_item(item_id, d["hadeeth"], ref, d.get("grade", ""),
                         repeat, None)
        item["hadeethenc_id"] = hid
        if ovr:
            item["dhikr"] = ovr
            item["dhikr_source"] = ("HadeethEnc %s explanation (verbatim "
                                    "extract)" % hid)
        if item_id == "la_hawla_wa_la_quwwata":
            item["grade_simple"] = "review_required"
            item["review"]["notes"] = ("E-1: wording is baqiyat-salihat, not "
                                       "the standalone hawqala; needs shaykh-1")
        items.append(item)
    pack = build_pack("tasbih-v1", "tasbih", items,
                      "HadeethEnc API (verbatim)")
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(pack, ensure_ascii=False, sort_keys=True,
                              indent=2) + "\n", encoding="utf-8")
    print("items:", len(items), pack["checksum"])
    for it in items:
        print(" ", it["id"], "|", it["grade_simple"], "|",
              it["arabic"][:50].replace("\n", " "))


if __name__ == "__main__":
    main()
