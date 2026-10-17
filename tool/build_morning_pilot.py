import hashlib, json, urllib.request, urllib.error

UA = {'User-Agent': 'Mozilla/5.0 MuslimGuide/0.1 research'}

def get(url):
    req = urllib.request.Request(url, headers=UA)
    return json.loads(urllib.request.urlopen(req, timeout=30).read().decode('utf-8'))

ids = ['6274','5490','5503','6082','6093','3008','65260','66086','5508']
items = []
for n, i in enumerate(ids, start=1):
    ar = get('https://hadeethenc.com/api/v1/hadeeths/one/?language=ar&id=' + i)
    try:
        en = get('https://hadeethenc.com/api/v1/hadeeths/one/?language=en&id=' + i)
        en_text, en_title, en_grade, en_attr = en.get('hadeeth'), en.get('title'), en.get('grade'), en.get('attribution')
    except urllib.error.HTTPError as e:
        en_text, en_title, en_grade, en_attr = None, None, None, None
        print('EN missing for ' + i + ' (HTTP ' + str(e.code) + ') — recorded as gap')
    items.append({
        'id': 'morning_%03d' % n,
        'hadeethenc_id': i,
        'arabic': ar.get('hadeeth'),
        'title_ar': ar.get('title'),
        'translation_en': en_text,
        'title_en': en_title,
        'grade': ar.get('grade'),
        'grade_en': en_grade,
        'attribution': ar.get('attribution'),
        'attribution_en': en_attr,
        'reference': ar.get('reference'),
        'categories': ar.get('categories'),
        'repeat': None,
        'review': {
            'status': 'pending',
            'reviewer': 'shaykh-1',
            'notes': '',
            'decided_at': None,
        },
    })
    print('saved ' + i + ' grade=' + str(ar.get('grade')))

pack = {
    'pack_id': 'morning',
    'category': 'core',
    'version': '0.1.0',
    'status': 'PENDING_REVIEW',
    'reviewer': 'shaykh-1',
    'reviewed_at': None,
    'license': 'HadeethEnc (NoDerivs + Attribution)',
    'source': {
        'provider': 'HadeethEnc.com',
        'category_id': '301',
        'category_title': 'اذكار الصباح والمساء',
        'api': 'https://hadeethenc.com/api/v1/',
        'retrieved_at': '2026-10-17',
    },
    'items': items,
    'approval': {
        'reviewer_id': 'shaykh-1',
        'approved_at': None,
        'version_approved': None,
        'checksum_approved': None,
    },
}
canon = json.dumps(pack, ensure_ascii=False, sort_keys=True, indent=2)
sha = hashlib.sha256(canon.encode('utf-8')).hexdigest()
pack['checksum'] = 'sha256:' + sha
pack['checksum_method'] = 'canonical-json-sha256-v1 (UTF-8, sort_keys, indent=2)'
final = json.dumps(pack, ensure_ascii=False, sort_keys=True, indent=2)
with open('assets/content/azkar/core/morning.json', 'w', encoding='utf-8') as f:
    f.write(final + '\n')
print('CHECKSUM=sha256:' + sha)
print('ITEMS=' + str(len(items)))
