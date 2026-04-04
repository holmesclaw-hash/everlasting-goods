from pathlib import Path
import re, json, textwrap, urllib.request

path = Path('src/lib/data.ts')
text = path.read_text()

if 'export interface FAQItem' not in text:
    text = text.replace(
        'export interface Article {\n',
        'export interface FAQItem {\n  question: string;\n  answer: string;\n}\n\nexport interface Article {\n',
    )
if 'faq?: FAQItem[];' not in text:
    text = text.replace('  content: string;\n}', '  content: string;\n  faq?: FAQItem[];\n}')

articles_start = text.index('export const articles: Article[] = [')
array_start = text.index('[', articles_start)
array_end = text.index('];\n\n// Helper functions', array_start)
array_body = text[array_start + 1:array_end]

objects = []
i = 0
while i < len(array_body):
    while i < len(array_body) and array_body[i] not in '{':
        i += 1
    if i >= len(array_body):
        break
    start = i
    depth = 0
    in_string = False
    quote = ''
    escape = False
    while i < len(array_body):
        ch = array_body[i]
        if in_string:
            if escape:
                escape = False
            elif ch == '\\':
                escape = True
            elif ch == quote:
                in_string = False
        else:
            if ch in ('"', "'", '`'):
                in_string = True
                quote = ch
            elif ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
                if depth == 0:
                    end = i + 1
                    obj = array_body[start:end]
                    objects.append(obj)
                    i = end
                    break
        i += 1


def field(obj: str, name: str):
    m = re.search(rf'\n\s+{name}: "([^"]*)"', obj)
    return m.group(1) if m else ''


def field_multiline_excerpt(obj: str):
    m = re.search(r'\n\s+excerpt:\n\s+"([\s\S]*?)",\n\s+category:', obj)
    return m.group(1).replace('\n', ' ').strip() if m else ''


def content_block(obj: str):
    m = re.search(r'\n\s+content: `(.*)`\n?\s*$', obj, re.S)
    return m.group(1) if m else None


def ts_escape(s: str) -> str:
    return s.replace('\\', '\\\\').replace('"', '\\"')


def call_qwen(prompt: str):
    data = json.dumps({"model": "qwen2.5:14b", "prompt": prompt, "stream": False}).encode()
    req = urllib.request.Request('http://localhost:11434/api/generate', data=data, headers={'Content-Type': 'application/json'})
    with urllib.request.urlopen(req, timeout=180) as resp:
        body = json.loads(resp.read().decode())
    return body['response']


title_map = {field(obj, 'slug'): field(obj, 'title') for obj in objects}
excerpt_map = {field(obj, 'slug'): field_multiline_excerpt(obj) for obj in objects}

related = {
    'best-cast-iron-skillets-that-last-forever': ['best-dutch-ovens-that-last-forever','best-kitchen-knives-that-last-a-lifetime','best-lodge-cast-iron-pieces-the-complete-collection-guide'],
    'best-buy-it-for-life-backpacks': ['best-buy-it-for-life-rain-jackets','best-edc-flashlights-that-last-forever','best-stainless-steel-water-bottles-that-last-forever'],
    'best-kitchen-knives-that-last-a-lifetime': ['best-cast-iron-skillets-that-last-forever','best-dutch-ovens-that-last-forever','best-buy-it-for-life-chef-s-knives-professional-picks'],
    'best-leather-boots-that-last-20-years': ['best-red-wing-boots-a-complete-buyer-s-guide','best-buy-it-for-life-rain-jackets','best-buy-it-for-life-gifts-under-50-quality-picks-that-last'],
    'best-edc-flashlights-that-last-forever': ['best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime','best-mechanical-watches-that-last-a-lifetime','best-stainless-steel-water-bottles-that-last-forever'],
    'best-dutch-ovens-that-last-forever': ['best-cast-iron-skillets-that-last-forever','best-kitchen-knives-that-last-a-lifetime','best-lodge-cast-iron-pieces-the-complete-collection-guide'],
    'best-mechanical-watches-that-last-a-lifetime': ['best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime','best-bifl-wallets-for-men-leather-wallets-that-age-beautifully','best-edc-flashlights-that-last-forever'],
    'best-woodworking-hand-tools-that-last-forever': ['best-hammers-that-last-a-lifetime','best-mechanical-keyboards-that-last-for-years','best-buy-it-for-life-gifts-under-50-quality-picks-that-last'],
    'best-lodge-cast-iron-pieces-the-complete-collection-guide': ['best-cast-iron-skillets-that-last-forever','best-dutch-ovens-that-last-forever','best-kitchen-knives-that-last-a-lifetime'],
    'best-bifl-wallets-for-men-leather-wallets-that-age-beautifully': ['best-mechanical-watches-that-last-a-lifetime','best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime','best-buy-it-for-life-gifts-under-50-quality-picks-that-last'],
    'best-buy-it-for-life-rain-jackets': ['best-buy-it-for-life-backpacks','best-leather-boots-that-last-20-years','best-stainless-steel-water-bottles-that-last-forever'],
    'best-stainless-steel-water-bottles-that-last-forever': ['best-buy-it-for-life-backpacks','best-buy-it-for-life-rain-jackets','best-buy-it-for-life-gifts-under-50-quality-picks-that-last'],
    'best-buy-it-for-life-gifts-under-50-quality-picks-that-last': ['best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime','best-stainless-steel-water-bottles-that-last-forever','best-cast-iron-skillets-that-last-forever'],
    'best-red-wing-boots-a-complete-buyer-s-guide': ['best-leather-boots-that-last-20-years','best-buy-it-for-life-rain-jackets','best-bifl-wallets-for-men-leather-wallets-that-age-beautifully'],
    'best-buy-it-for-life-chef-s-knives-professional-picks': ['best-kitchen-knives-that-last-a-lifetime','best-cast-iron-skillets-that-last-forever','best-dutch-ovens-that-last-forever'],
    'best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime': ['best-mechanical-watches-that-last-a-lifetime','best-bifl-wallets-for-men-leather-wallets-that-age-beautifully','best-edc-flashlights-that-last-forever'],
    'best-washers-and-dryers-that-last-forever': ['best-mechanical-keyboards-that-last-for-years','best-hammers-that-last-a-lifetime','best-stainless-steel-water-bottles-that-last-forever'],
    'best-hammers-that-last-a-lifetime': ['best-woodworking-hand-tools-that-last-forever','best-washers-and-dryers-that-last-forever','best-buy-it-for-life-gifts-under-50-quality-picks-that-last'],
    'best-mechanical-keyboards-that-last-for-years': ['best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime','best-mechanical-watches-that-last-a-lifetime','best-woodworking-hand-tools-that-last-forever'],
}


def make_related_html(slug: str) -> str:
    items = [f'<li><a href="/articles/{rs}">{title_map[rs]}</a></li>' for rs in related.get(slug, []) if rs in title_map][:3]
    if not items:
        return ''
    return (
        '\n<section class="mt-10 related-reading">\n'
        '<h2 id="related-reading">Related Reading</h2>\n'
        "<p>If you're building a durable setup, these guides pair naturally with this topic:</p>\n"
        '<ul>\n' + '\n'.join(items) + '\n</ul>\n'
        '</section>'
    )


def make_faq_section(faqs) -> str:
    parts = ['<section class="mt-12 faq-section">', '<h2 id="faq">Frequently Asked Questions</h2>']
    for item in faqs:
        parts.append(f'<h3>{item["question"]}</h3>')
        parts.append(f'<p>{item["answer"]}</p>')
    parts.append('</section>')
    return '\n'.join(parts)


new_objects = []
updated = 0
for obj in objects:
    slug = field(obj, 'slug')
    title = field(obj, 'title')
    content = content_block(obj)
    if content is None:
        new_objects.append(obj)
        continue
    if '<h2 id="faq">Frequently Asked Questions</h2>' in content and 'faq: [' in obj:
        new_objects.append(obj)
        continue

    prompt = textwrap.dedent(f'''\
    You are generating SEO FAQ content for a product-review article.
    Return JSON only in this exact shape:
    {{"faqs":[{{"question":"...","answer":"..."}}]}}

    Requirements:
    - 4 FAQs
    - Questions should target search intent and be specific to the article title
    - Answers 2-4 sentences each
    - No markdown, no code fences
    - Keep claims practical and editorial, not salesy

    Title: {title}
    Excerpt: {excerpt_map.get(slug, '')}
    Existing article HTML:\n{content[:5000]}
    ''')
    try:
        raw = call_qwen(prompt)
        match = re.search(r'\{[\s\S]*\}', raw)
        faq_data = json.loads(match.group(0)) if match else {"faqs": []}
        faqs = faq_data.get('faqs', [])[:5]
    except Exception:
        faqs = []

    cleaned = []
    for item in faqs:
        q = ' '.join(str(item.get('question', '')).split()).strip('" ')
        a = ' '.join(str(item.get('answer', '')).split()).strip('" ')
        if q and a:
            cleaned.append({'question': q, 'answer': a})
    if not cleaned:
        cleaned = [
            {"question": f"What makes {title.lower()} a buy-it-for-life topic?", "answer": "The best options in this category combine durable materials, long-term repairability, and strong owner reputation. We prioritize products that stay useful for years instead of chasing flashy short-term features."},
            {"question": f"How much should you spend on {title.lower()}?", "answer": "The right budget depends on how often you use the product and whether it can be repaired or maintained. Spending more upfront usually makes sense when it buys you better materials, parts support, and a longer service life."},
            {"question": f"What matters most when comparing {title.lower()}?", "answer": "Look first at construction quality, warranty support, and real-world reliability. Those factors usually tell you more about long-term value than marketing claims or a long feature list."},
            {"question": f"How do you make {title.lower()} last longer?", "answer": "Basic maintenance, proper storage, and using the item the way it was designed all extend service life. Even the best product lasts longer when you keep up with simple care instead of waiting until something fails."},
        ]

    new_content = content.rstrip() + make_related_html(slug) + '\n\n' + make_faq_section(cleaned) + '\n    '
    faq_ts = 'faq: [\n' + ',\n'.join(
        f'      {{ question: "{ts_escape(item["question"])}", answer: "{ts_escape(item["answer"])}" }}' for item in cleaned
    ) + '\n    ]'

    obj2 = re.sub(r'\n\s+content: `.*`\n?\s*$', f'\n    content: `{new_content}`,\n    {faq_ts}\n  ', obj, flags=re.S)
    new_objects.append(obj2)
    updated += 1

new_array = '[\n' + ',\n'.join(new_objects) + '\n]'
text = text[:array_start] + new_array + text[array_end:]
path.write_text(text)
print(f'updated {updated} articles')
