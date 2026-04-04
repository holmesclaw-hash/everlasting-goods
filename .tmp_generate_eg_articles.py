import json, urllib.request, os, time

OLLAMA_URL = 'http://localhost:11434/api/generate'
MODEL = 'qwen2.5:14b'
TAG = 'everlastin09f-20'

articles = [
  {
    'topic': 'Speed Queen washers and dryers',
    'trend_context': 'Trending from r/BuyItForLife: "Finally found a set of Speed Queen commercial washer and dryer." High durability/home-appliance interest.',
    'title_hint': 'Best Washers and Dryers That Last Forever',
    'slug': 'best-washers-and-dryers-that-last-forever',
    'category': 'home',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Cash_card-operated_Speed_Queen_commercial_washers_and_dryers.JPG/1280px-Cash_card-operated_Speed_Queen_commercial_washers_and_dryers.JPG',
    'author': 'Sarah Mitchell'
  },
  {
    'topic': 'Estwing hammers',
    'trend_context': 'Trending from r/BuyItForLife: "Estwing Hammer. 25 years old, It\'s a classic." Strong tools/BIFL signal.',
    'title_hint': 'Best Hammers That Last a Lifetime',
    'slug': 'best-hammers-that-last-a-lifetime',
    'category': 'tools',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Estwing_hammer.JPG/1280px-Estwing_hammer.JPG',
    'author': 'Marcus Rivera'
  },
  {
    'topic': 'Mechanical keyboards built to last',
    'trend_context': 'Trending from r/MechanicalKeyboards: "Got my Retro style keyboard!" and other keyboard collection posts. Strong enthusiast demand with clear product recommendations.',
    'title_hint': 'Best Mechanical Keyboards That Last for Years',
    'slug': 'best-mechanical-keyboards-that-last-for-years',
    'category': 'home',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Keychron_K8_Non-Backlight_Wireless_Mechanical_Keyboard_-_52772912798.jpg/1280px-Keychron_K8_Non-Backlight_Wireless_Mechanical_Keyboard_-_52772912798.jpg',
    'author': 'Alex Nakamura'
  }
]

results = []
for item in articles:
    prompt = f'''Write a single JSON object for an affiliate content article for Everlasting Goods.

Return ONLY valid JSON. No markdown fences. No commentary.

Required JSON fields:
- title
- slug
- excerpt
- category
- image
- author
- date
- readTime
- featured
- products (array of strings; can be empty)
- content

Constraints:
- Use title exactly: {item['title_hint']}
- Use slug exactly: {item['slug']}
- Use category exactly: {item['category']}
- Use image exactly: {item['image']}
- Use author exactly: {item['author']}
- Use date exactly: 2026-04-04
- Use readTime around 12 to 16 min read
- Use featured: false
- Use products: []
- content must be HTML fragment only, not full HTML document
- Write roughly 1300-1700 words
- Tone: expert, practical, no fluff, BIFL-oriented
- Include an intro, buying criteria, top recommendations, care/maintenance, and verdict
- Mention 4-6 specific products/brands with pros/cons
- Every product mention in the HTML should contain an Amazon affiliate link using tag {TAG}
- Use either /s?k= search links or /dp/ links; all must include tag={TAG}
- Add rel="nofollow noopener" and target="_blank" to affiliate links
- Avoid fake testing claims; synthesize from known brand reputation, repairability, warranty, materials, and enthusiast consensus
- Do not mention Reddit directly in the final article
- Avoid duplicate topics already covered on the site: cast iron skillets, backpacks, kitchen knives, leather boots, flashlights, dutch ovens, mechanical watches, woodworking hand tools, safety razors, water bottles, stand mixers, camping gear, furniture, multitools
- Topic focus: {item['topic']}
- Trend context for angle only: {item['trend_context']}
- Excerpt should be 1-2 sentences and compelling.
'''
    data = json.dumps({'model': MODEL, 'prompt': prompt, 'stream': False}).encode()
    req = urllib.request.Request(OLLAMA_URL, data=data, headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req, timeout=600) as r:
        resp = json.load(r)
    text = resp['response'].strip()
    obj = json.loads(text)
    results.append(obj)
    time.sleep(1)

out = '/Users/holmes/.openclaw/workspace/projects/everlasting-goods/generated-articles-2026-04-04.json'
with open(out, 'w') as f:
    json.dump(results, f, indent=2)
print(out)
