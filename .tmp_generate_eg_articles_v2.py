import json, urllib.request, time
OLLAMA_URL = 'http://localhost:11434/api/generate'
MODEL = 'qwen2.5:14b'
TAG = 'everlastin09f-20'
articles = [
  {
    'topic': 'Speed Queen washers and dryers',
    'trend_context': 'Trending from r/BuyItForLife around long-lived laundry appliances and Speed Queen enthusiasm.',
    'title_hint': 'Best Washers and Dryers That Last Forever',
    'slug': 'best-washers-and-dryers-that-last-forever',
    'category': 'home',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/13/Cash_card-operated_Speed_Queen_commercial_washers_and_dryers.JPG/1280px-Cash_card-operated_Speed_Queen_commercial_washers_and_dryers.JPG',
    'author': 'Sarah Mitchell'
  },
  {
    'topic': 'Estwing hammers and long-life striking tools',
    'trend_context': 'Trending from r/BuyItForLife around decades-old Estwing hammers still in service.',
    'title_hint': 'Best Hammers That Last a Lifetime',
    'slug': 'best-hammers-that-last-a-lifetime',
    'category': 'tools',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Estwing_hammer.JPG/1280px-Estwing_hammer.JPG',
    'author': 'Marcus Rivera'
  },
  {
    'topic': 'Mechanical keyboards built to last',
    'trend_context': 'Trending from r/MechanicalKeyboards around retro boards, collections, and long-life enthusiast gear.',
    'title_hint': 'Best Mechanical Keyboards That Last for Years',
    'slug': 'best-mechanical-keyboards-that-last-for-years',
    'category': 'home',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Keychron_K8_Non-Backlight_Wireless_Mechanical_Keyboard_-_52772912798.jpg/1280px-Keychron_K8_Non-Backlight_Wireless_Mechanical_Keyboard_-_52772912798.jpg',
    'author': 'Alex Nakamura'
  }
]
for item in articles:
    prompt = f'''Return ONLY a valid JSON object. No markdown. No explanations.

You are writing a polished long-form article for Everlasting Goods, a Buy It For Life affiliate publication.

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
- products
- content

Set these exactly:
- title = {item['title_hint']}
- slug = {item['slug']}
- category = {item['category']}
- image = {item['image']}
- author = {item['author']}
- date = 2026-04-04
- readTime = 15 min read
- featured = false
- products = []

Critical content requirements:
- content must be an HTML fragment only
- minimum 12000 characters in content
- target 1400-1700 words
- no filler, no fake testing language, no Reddit mention
- include these sections in order using <h2> tags:
  1. Why This Category Is BIFL-Worthy
  2. How We Evaluate Long-Life Options
  3. Our Top Pick
  4. Other Excellent Options
  5. Budget Pick or Value Pick
  6. What Most Buyers Get Wrong
  7. Care and Maintenance
  8. Who Should Buy What
  9. Final Verdict
- in the recommendations sections, discuss at least 5 specific products/brands total
- every named product or brand mention in a recommendation section must include an Amazon affiliate link with exact tag {TAG}
- use clean HTML with paragraphs, unordered lists, and occasional <strong>
- rel="nofollow noopener" and target="_blank" on all affiliate links
- avoid unsupported specifics like exact warranties or dimensions unless broadly reliable
- write with strong editorial judgment and practical advice
- theme/topic = {item['topic']}
- angle context = {item['trend_context']}
- avoid duplicate topics already covered on site: cast iron skillets, backpacks, kitchen knives, leather boots, flashlights, dutch ovens, mechanical watches, woodworking hand tools, safety razors, water bottles, stand mixers, camping gear, furniture, multitools
'''
    req = urllib.request.Request(OLLAMA_URL, data=json.dumps({'model': MODEL, 'prompt': prompt, 'stream': False}).encode(), headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req, timeout=900) as r:
        resp = json.load(r)
    text = resp['response'].strip()
    obj = json.loads(text)
    path = f"/Users/holmes/.openclaw/workspace/projects/everlasting-goods/{item['slug']}.json"
    with open(path,'w') as f:
        json.dump(obj, f, indent=2)
    print(path, len(obj['content']))
    time.sleep(1)
