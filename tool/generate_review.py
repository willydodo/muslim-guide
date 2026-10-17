"""Generate an offline review HTML + decisions JSON skeleton for an azkar pack.

Usage:
  python tool/generate_review.py assets/content/azkar/core/morning.json

Reads the pack JSON, emits:
  content/reviews/<pack_id>-review-<YYYY-MM-DD>.html   (offline, RTL, no external resources)
  content/reviews/<pack_id>-review-<YYYY-MM-DD>.json   (sent copy manifest)

The reviewer opens the HTML, clicks approve/edit/reject per item, and exports
decisions JSON. No network, no modification of the pack by this script.
"""
import datetime
import html
import json
import sys
from pathlib import Path


def main() -> None:
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else Path('assets/content/azkar/core/morning.json')
    pack = json.loads(src.read_text(encoding='utf-8'))
    pack_id = pack['pack_id']
    today = datetime.date.today().isoformat()
    out_dir = Path('content/reviews')
    out_dir.mkdir(parents=True, exist_ok=True)
    html_path = out_dir / ('%s-review-%s.html' % (pack_id, today))
    json_path = out_dir / ('%s-review-%s.json' % (pack_id, today))

    cards = []
    for it in pack['items']:
        arid = html.escape(it['id'])
        arabic = html.escape(it.get('arabic') or '')
        title = html.escape(it.get('title_ar') or '')
        grade = html.escape(str(it.get('grade') or ''))
        attr = html.escape(str(it.get('attribution') or ''))
        hid = html.escape(str(it.get('hadeethenc_id') or ''))
        cards.append(
            '\n'.join([
                '  <div class="item" data-id="%s">' % arid,
                '    <h3>%s — %s</h3>' % (arid, title),
                '    <p class="arabic">%s</p>' % arabic,
                '    <p class="source">HadeethEnc %s — %s — %s</p>' % (hid, attr, grade),
                '    <div class="actions">',
                '      <button onclick="decide(\'%s\',\'approved\')">موافق</button>' % arid,
                '      <button onclick="decide(\'%s\',\'edited\')">تعديل</button>' % arid,
                '      <button onclick="decide(\'%s\',\'rejected\')">رفض</button>' % arid,
                '    </div>',
                '    <textarea data-notes="%s" placeholder="ملاحظات / مصدر التعديل..."></textarea>' % arid,
                '    <textarea data-proposed="%s" placeholder="النص المقترح (للتعديل فقط)..."></textarea>' % arid,
                '  </div>',
            ])
        )

    page = '\n'.join([
        '<!DOCTYPE html>',
        '<html dir="rtl" lang="ar">',
        '<head>',
        '  <meta charset="UTF-8">',
        '  <meta name="viewport" content="width=device-width, initial-scale=1">',
        '  <title>مراجعة: %s v%s</title>' % (html.escape(pack_id), html.escape(str(pack.get('version')))),
        '  <style>body{font-family:sans-serif;max-width:800px;margin:auto;padding:16px}'
        '.arabic{font-size:1.3em;line-height:2}.item{border:1px solid #ccc;margin:12px 0;padding:12px}'
        'textarea{width:100%;min-height:48px;margin-top:8px}</style>',
        '</head>',
        '<body>',
        '  <h1>حزمة: %s — v%s</h1>' % (html.escape(pack_id), html.escape(str(pack.get('version')))),
        '  <p>المصدر: HadeethEnc.com — الفئة 301 (أذكار الصباح والمساء)</p>',
        '  <p>المراجع: shaykh-1 — الحالة: PENDING_REVIEW</p>',
        '  <p>checksum المحتوى: <code>%s</code></p>' % html.escape(str(pack.get('checksum'))),
        '\n'.join(cards),
        '  <button onclick="exportDecisions()">حفظ القرارات (JSON)</button>',
        '  <script>',
        '    const decisions = {};',
        "    function decide(id, status) { decisions[id] = {status: status}; }",
        '    function exportDecisions() {',
        '      const out = Object.entries(decisions).map(([id, v]) => ({',
        '        id, status: v.status,',
        '        notes: document.querySelector(\'[data-notes=\"\' + id + \'"]\').value,',
        '        proposed_text: document.querySelector(\'[data-proposed=\"\' + id + \'"]\').value || null,',
        '        decided_at: new Date().toISOString()',
        '      }));',
        '      const blob = new Blob([JSON.stringify({pack_id: "%s", version: "%s", checksum: "%s", decisions: out}, null, 2)], { type: "application/json" });' % (
            html.escape(pack_id), html.escape(str(pack.get('version'))), html.escape(str(pack.get('checksum')))),
        '      const a = document.createElement("a");',
        '      a.href = URL.createObjectURL(blob);',
        '      a.download = "decisions-%s-%s.json";' % (pack_id, today),
        '      a.click();',
        '    }',
        '  </script>',
        '</body>',
        '</html>',
    ])
    html_path.write_text(page, encoding='utf-8')
    json_path.write_text(json.dumps(pack, ensure_ascii=False, sort_keys=True, indent=2) + '\n', encoding='utf-8')
    print('HTML: ' + str(html_path))
    print('JSON: ' + str(json_path))


if __name__ == '__main__':
    main()
