import json, re, urllib.request
from pathlib import Path

TOPICS = json.loads(Path('/Users/holmes/.openclaw/workspace/projects/everlasting-goods/article-topics-2026-04-11.json').read_text())['topics']
OUT = Path('/Users/holmes/.openclaw/workspace/projects/everlasting-goods/generated-articles-2026-04-11.json')
MODEL = 'qwen2.5:14b'
URL = 'http://localhost:11434/api/generate'

SYSTEM = '''You write publishable long-form affiliate articles for Everlasting Goods, a Buy It For Life product site.
Return valid JSON only, with these keys exactly:
slug, title, excerpt, category, image, author, date, readTime, featured, products, content.
content must be a single HTML string.
Aim for about 1200 to 1700 words.
Tone: direct, opinionated, useful, zero fluff.
Use Amazon affiliate links with tag everlastin09f-20 on every product mention.
Include: intro, top picks, how to choose, maintenance or care, verdict, related reading, FAQ.
Do not mention Reddit.
Do not wrap output in markdown fences.
'''

def generate(topic):
    prompt = f'''Write one article as JSON.
slug: {topic['slug']}
title: {topic['title']}
category: {topic['category']}
image: {topic['image']}
date: 2026-04-11
Angle: {topic['topic_angle']}
Requirements:
- Byline should be a plausible human name.
- readTime should be around 11 to 15 min read.
- featured false.
- excerpt one sentence.
- HTML should be production ready for a TypeScript template string.
- Escape any double quotes inside JSON strings correctly.
'''
    body = json.dumps({
        'model': MODEL,
        'prompt': SYSTEM + '\n' + prompt,
        'stream': False,
        'format': 'json',
        'options': {'temperature': 0.7, 'num_predict': 5000}
    }).encode()
    req = urllib.request.Request(URL, data=body, headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req, timeout=1800) as r:
        payload = json.loads(r.read().decode())
    raw = payload['response'].strip()
    raw = re.sub(r'^```(?:json)?\s*', '', raw)
    raw = re.sub(r'\s*```$', '', raw)
    return json.loads(raw)

results = []
for topic in TOPICS:
    results.append(generate(topic))
    OUT.write_text(json.dumps(results, indent=2))

print(str(OUT))
