"""Merge shaykh-1 decisions into morning.json per 08-review-workflow rules.

Decisions (human, Rule 020):
  1. rejected w/o reason -> keep item, status=rejected, gap recorded.
  2. edited from Bukhari/Muslim -> REJECT HadeethEnc text replacement;
     keep HadeethEnc arabic, store proposed_text + edit_source + edit_decision.
  3. dual-save proposed texts for documentation.

Result: status=PARTIALLY_APPROVED (5 approved + 2 rejected + 2 edited_rejected).
No full APPROVED. Pack content checksum covers content fields only
(per 08-review-workflow: approval + review fields excluded).
"""
import hashlib
import json

PACK = 'assets/content/azkar/core/morning.json'
DEC = 'content/reviews/decisions-morning-2026-10-17.json'

pack = json.loads(open(PACK, encoding='utf-8').read())
dec = json.loads(open(DEC, encoding='utf-8').read())

assert dec['checksum'] == pack['checksum'], 'decisions target a different pack version'
assert dec['pack_id'] == pack['pack_id']

EDIT_SOURCES = {
    'morning_003': 'صحيح البخاري',
    'morning_006': 'صحيح مسلم (2723)',
}
EDIT_REASONS = {
    'morning_003': 'HadeethEnc NoDerivs + البخاري غير مرخص — التعديل مرفوض، نص HadeethEnc باقٍ',
    'morning_006': 'HadeethEnc NoDerivs — التعديل مرفوض، نص HadeethEnc باقٍ',
}

by_id = {d['id']: d for d in dec['decisions']}
approved = rejected = edited_rejected = 0
for it in pack['items']:
    d = by_id[it['id']]
    st = d['status']
    if st == 'approved':
        it['review'] = {'status': 'approved', 'reviewer': 'shaykh-1',
                        'notes': d['notes'] or '', 'decided_at': '2026-10-17'}
        approved += 1
    elif st == 'rejected':
        it['review'] = {'status': 'rejected', 'reviewer': 'shaykh-1',
                        'notes': d['notes'] or '', 'decided_at': '2026-10-17'}
        rejected += 1
    elif st == 'edited':
        it['proposed_text'] = d['proposed_text']
        it['edit_source'] = EDIT_SOURCES[it['id']]
        it['edit_decision'] = 'REJECTED'
        it['edit_reason'] = EDIT_REASONS[it['id']]
        it['review'] = {'status': 'approved', 'reviewer': 'shaykh-1',
                        'notes': 'اقترح تعديل من %s — رُفض (%s)' % (
                            EDIT_SOURCES[it['id']], d['notes'] or ''),
                        'decided_at': '2026-10-17'}
        approved += 1
        edited_rejected += 1
    else:
        raise ValueError('unknown decision status: ' + st)

pack['status'] = 'PARTIALLY_APPROVED'
pack['reviewed_at'] = '2026-10-17'
pack['approval_summary'] = {'total': 9, 'approved': approved,
                            'rejected': rejected,
                            'edited_rejected': edited_rejected}

content_keys = ('pack_id', 'category', 'version', 'license', 'source', 'items')
content = {k: pack[k] for k in content_keys}
# Exclude review/proposal bookkeeping from the content checksum.
items_nc = []
for it in content['items']:
    it2 = {k: v for k, v in it.items()
           if k not in ('review', 'proposed_text', 'edit_source',
                        'edit_decision', 'edit_reason')}
    items_nc.append(it2)
content['items'] = items_nc
canon = json.dumps(content, ensure_ascii=False, sort_keys=True, indent=2)
sha = hashlib.sha256(canon.encode('utf-8')).hexdigest()
pack['checksum'] = 'sha256:' + sha
pack['checksum_method'] = 'canonical-json-sha256-v1 content-only (excl. review/proposal/approval fields; UTF-8, sort_keys, indent=2)'

pack['approval'] = {'reviewer_id': 'shaykh-1', 'approved_at': None,
                    'version_approved': None, 'checksum_approved': None}

final = json.dumps(pack, ensure_ascii=False, sort_keys=True, indent=2)
open(PACK, 'w', encoding='utf-8').write(final + '\n')
print('APPROVED=%d REJECTED=%d EDITED_REJECTED=%d' % (approved, rejected, edited_rejected))
print('CHECKSUM=sha256:' + sha)
