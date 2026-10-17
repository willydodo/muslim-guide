import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from core_v2_common import build_pack, make_item

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "الأذكار الجزء الثانى.txt"
OUT_DIR = ROOT / "assets" / "content" / "azkar" / "core_v2"

FILES = [
    ("النوم والاستيقاظ", "wake_sleep.json", "wake-sleep-v2", "wakesleep"),
    ("المنزل", "home.json", "home-v2", "home"),
    ("المسجد والأذان", "mosque.json", "mosque-v2", "mosque"),
    ("الصلاة", "prayer.json", "prayer-v2", "prayer"),
    ("الهم والكرب والدين", "distress.json", "distress-v2", "distress"),
    ("الخوف والأعداء", "fear.json", "fear-v2", "fear"),
    ("الشيطان والوساوس والحماية", "satan.json", "satan-v2", "satan"),
    ("التوبة والاستغفار", "repentance.json", "repentance-v2", "repent"),
    ("المرض والرقية", "illness.json", "illness-v2", "illness"),
    ("الموت والجنائز", "funeral.json", "funeral-v2", "funeral"),
    ("المولود والزواج والأولاد", "newborn.json", "newborn-v2", "newborn"),
    ("الطعام والصيام", "food.json", "food-v2", "food"),
    ("MISC", "misc.json", "misc-v2", "misc"),
]

MISC_TOPS = ['الريح والمطر والرعد', 'السفر والركوب', 'الحج والعمرة والذبح', 'المجالس والمعاملات والآداب الاجتماعية', 'فضل التسبيح والتهليل', 'كيف كان النبي يسبح']

META = ("المصدر:", "الدرجة:", "التكرار:", "مرجع قرآني:")


def is_mark(s):
    import re as _re
    return bool(_re.match(r"^الذكر\s+\d+\s*$", s))
def parse_block(block):
    parts, source, degree, repeat, quran = [], "", "", 1, None
    for ln in [x.strip() for x in block.strip().splitlines() if x.strip()]:
        if ln.startswith("المصدر:"):
            source = ln[len("المصدر:"):].strip()
        elif ln.startswith("الدرجة:"):
            degree = ln[len("الدرجة:"):].strip()
        elif ln.startswith("التكرار:"):
            try:
                repeat = int(ln[len("التكرار:"):].strip())
            except ValueError:
                repeat = 1
        elif ln.startswith("مرجع قرآني:"):
            quran = ln[len("مرجع قرآني:"):].strip()
        else:
            parts.append(ln)
    return "\n".join(parts), source, degree, repeat, quran


def next_ne(lines, k):
    n = len(lines)
    while k < n:
        if lines[k].strip():
            return k, lines[k].strip()
        k += 1
    return None, ""


def split_sections(raw, tops, misc_tops):
    lines = raw.splitlines()
    bounds = []
    for i, ln in enumerate(lines):
        s = ln.strip()
        if len(s) > 40:
            continue
        for t in tops:
            if s == t or (t in s and abs(len(s) - len(t)) < 6):
                bounds.append((i, t))
                break
    out = []
    for bi, (lno, top) in enumerate(bounds):
        end = bounds[bi + 1][0] if bi + 1 < len(bounds) else len(lines)
        body = "\n".join(lines[lno + 1:end])
        key = "MISC" if top in misc_tops else top
        out.append((key, top, body))
    return out

def collect_items(body, top):
    lines = body.splitlines()
    n = len(lines)
    items = []
    cur_sub = top
    cur = None
    i = 0
    while i < n:
        s = lines[i].strip()
        if is_mark(s):
            if cur is not None:
                items.append((cur[0], "\n".join(cur[1])))
            cur = [cur_sub, []]
            i += 1
            continue
        if not s:
            if cur is not None:
                cur[1].append("")
            i += 1
            continue
        if s.startswith(META):
            if cur is not None:
                cur[1].append(lines[i])
            i += 1
            continue
        if cur is None:
            if len(s) < 60:
                cur_sub = s
            i += 1
            continue
        has_text = "".join(cur[1]).strip() != ""
        has_meta = any(
            x.strip().startswith(META) for x in cur[1] if x.strip())
        if len(s) < 60 and not s.startswith("["):
            ni, ns = next_ne(lines, i + 1)
            mi, ms = next_ne(lines, ni + 1) if ni is not None else (None, "")
            is_m = ni is not None and is_mark(ns)
            is_h = ms.startswith("المصدر:") and not ns.startswith(META)
            # trailing sub-header: short line after meta, followed by
            # blank/end or next MARK — belongs to NEXT block, not text
            is_trail = (has_meta and (ni is None or is_m or ns == ""))
            if (not has_text and (is_m or is_h)) or is_trail:
                cur_sub = s
                cur[0] = s
                i += 1
                continue
        cur[1].append(lines[i])
        i += 1
    if cur is not None:
        items.append((cur[0], "\n".join(cur[1])))
    return items


def main():
    raw = SRC.read_text(encoding="utf-8")
    tops = [f[0] for f in FILES if f[0] != "MISC"] + MISC_TOPS
    secs = split_sections(raw, tops, MISC_TOPS)
    buckets = {}
    for key, top, body in secs:
        buckets.setdefault(key, []).append((top, body))
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    grand = 0
    for f in FILES:
        key, fname, pack_id, prefix = f
        n = 0
        items = []
        for top, body in buckets.get(key, []):
            for sub, block in collect_items(body, top):
                n += 1
                arabic, source, degree, repeat, quran = parse_block(block)
                item_id = "%s_%02d" % (prefix, n)
                items.append(make_item(item_id, arabic, source, degree,
                                       repeat, quran))
        pack = build_pack(pack_id, "core", items, "الأذكار الجزء الثانى.txt")
        (OUT_DIR / fname).write_text(
            json.dumps(pack, ensure_ascii=False, sort_keys=True,
                       indent=2) + "\n", encoding="utf-8")
        print(fname, ":", len(items), pack["checksum"][:19])
        grand += len(items)
    print("TOTAL:", grand)


if __name__ == "__main__":
    main()
