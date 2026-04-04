#!/usr/bin/env python3
"""
Generate FAQ sections via Ollama and add internal links to articles in data.ts.
Outputs the HTML snippets to append to each article's content.
"""
import json
import urllib.request
import re
import sys

# All articles extracted from data.ts with their slugs, titles, categories
articles = [
    {"slug": "best-cast-iron-skillets-that-last-forever", "title": "Best Cast Iron Skillets That Last Forever", "category": "kitchen", "has_content": True},
    {"slug": "best-buy-it-for-life-backpacks", "title": "Best Buy It For Life Backpacks", "category": "outdoor", "has_content": True},
    {"slug": "best-kitchen-knives-that-last-a-lifetime", "title": "Best Kitchen Knives That Last a Lifetime", "category": "kitchen", "has_content": True},
    {"slug": "best-leather-boots-that-last-20-years", "title": "Best Leather Boots That Last 20+ Years", "category": "clothing", "has_content": True},
    {"slug": "best-edc-flashlights-that-last-forever", "title": "Best EDC Flashlights That Last Forever", "category": "edc", "has_content": True},
    {"slug": "best-dutch-ovens-that-last-forever", "title": "Best Dutch Ovens That Last Forever", "category": "kitchen", "has_content": True},
    {"slug": "best-mechanical-watches-that-last-a-lifetime", "title": "Best Mechanical Watches That Last a Lifetime", "category": "edc", "has_content": True},
    {"slug": "best-woodworking-hand-tools-that-last-forever", "title": "Best Woodworking Hand Tools That Last Forever", "category": "tools", "has_content": True},
    {"slug": "best-lodge-cast-iron-pieces-the-complete-collection-guide", "title": "Best Lodge Cast Iron Pieces: The Complete Collection Guide", "category": "kitchen", "has_content": True},
    {"slug": "best-bifl-wallets-for-men-leather-wallets-that-age-beautifully", "title": "Best BIFL Wallets for Men: Leather Wallets That Age Beautifully", "category": "home", "has_content": False},
    {"slug": "best-buy-it-for-life-rain-jackets", "title": "Best Buy It For Life Rain Jackets", "category": "home", "has_content": False},
    {"slug": "best-stainless-steel-water-bottles-that-last-forever", "title": "Best Stainless Steel Water Bottles That Last Forever", "category": "edc", "has_content": True},
    {"slug": "best-buy-it-for-life-gifts-under-50-quality-picks-that-last", "title": "Best Buy It For Life Gifts Under $50: Quality Picks That Last", "category": "home", "has_content": True},
    {"slug": "best-red-wing-boots-a-complete-buyer-s-guide", "title": "Best Red Wing Boots: A Complete Buyer's Guide", "category": "clothing", "has_content": True},
    {"slug": "best-buy-it-for-life-chef-s-knives-professional-picks", "title": "Best Buy It For Life Chef's Knives: Professional Picks", "category": "kitchen", "has_content": True},
    {"slug": "best-buy-it-for-life-bifl-everyday-carry-pens-pens-that-last-a-lifetime", "title": "Best Buy It For Life (BIFL) Everyday Carry Pens: Pens That Last a Lifetime", "category": "edc", "has_content": True},
]

def get_internal_links(current_slug, current_category):
    """Get 2-3 related articles for internal linking."""
    # Prefer same category first, then others
    same_cat = [a for a in articles if a["slug"] != current_slug and a["category"] == current_category and a["has_content"]]
    diff_cat = [a for a in articles if a["slug"] != current_slug and a["category"] != current_category and a["has_content"]]

    links = []
    for a in same_cat[:2]:
        links.append(a)
    if len(links) < 3:
        for a in diff_cat[:3 - len(links)]:
            links.append(a)
    return links

def generate_faqs_ollama(title, category):
    """Generate 3-5 FAQs using Ollama."""
    prompt = f"""Generate exactly 4 frequently asked questions and concise answers about the topic: "{title}".
Category: {category} (buy-it-for-life durable goods).
Format your response as a JSON array of objects with "question" and "answer" fields.
Each answer should be 1-2 sentences, practical and informative.
Only output the JSON array, no other text."""

    payload = json.dumps({
        "model": "qwen2.5:14b",
        "prompt": prompt,
        "stream": False,
        "options": {"temperature": 0.7, "num_predict": 1024}
    }).encode()

    req = urllib.request.Request(
        "http://localhost:11434/api/generate",
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST"
    )

    try:
        with urllib.request.urlopen(req, timeout=120) as resp:
            result = json.loads(resp.read().decode())
            response_text = result.get("response", "")
            # Try to extract JSON from the response
            # Look for JSON array pattern
            match = re.search(r'\[[\s\S]*?\]', response_text)
            if match:
                faqs = json.loads(match.group())
                return faqs[:5]  # Cap at 5
    except Exception as e:
        print(f"  Error generating FAQs for {title}: {e}", file=sys.stderr)

    return None

def build_html_section(article, internal_links, faqs):
    """Build the HTML to append to an article's content."""
    html_parts = []

    # Internal links section
    if internal_links:
        html_parts.append('\n<h2 id="related-reading">Related Reading</h2>')
        html_parts.append('<p>If you enjoyed this guide, check out these related articles:</p>')
        html_parts.append('<ul>')
        for link in internal_links:
            html_parts.append(f'<li><a href="/articles/{link["slug"]}">{link["title"]}</a></li>')
        html_parts.append('</ul>')

    # FAQ section
    if faqs:
        html_parts.append('\n<h2 id="faq">Frequently Asked Questions</h2>')
        html_parts.append('<div class="faq-section">')
        for faq in faqs:
            q = faq["question"].replace('"', '&quot;').replace("'", "&#39;")
            a = faq["answer"].replace('"', '&quot;').replace("'", "&#39;")
            # Keep clean for FAQ extraction
            html_parts.append(f'<div class="faq-item"><h3 class="faq-question">{q}</h3><p>{a}</p></div>')
        html_parts.append('</div>')

    return '\n'.join(html_parts)

def main():
    results = {}

    for article in articles:
        if not article["has_content"]:
            print(f"Skipping {article['slug']} (no content)", file=sys.stderr)
            continue

        print(f"Processing: {article['slug']}", file=sys.stderr)

        # Get internal links
        internal_links = get_internal_links(article["slug"], article["category"])

        # Generate FAQs
        print(f"  Generating FAQs via Ollama...", file=sys.stderr)
        faqs = generate_faqs_ollama(article["title"], article["category"])

        if faqs:
            print(f"  Got {len(faqs)} FAQs", file=sys.stderr)
        else:
            print(f"  FAQ generation failed, using fallback", file=sys.stderr)
            faqs = [
                {"question": f"How long do the products in this guide typically last?", "answer": "With proper care and maintenance, the products featured in this guide are designed to last decades or even a lifetime, making them true buy-it-for-life investments."},
                {"question": f"Are these products worth the higher upfront cost?", "answer": "Yes. While the initial investment is higher, the cost-per-year of use is significantly lower than repeatedly buying cheaper alternatives that wear out."},
                {"question": f"What is the most important factor when choosing a BIFL product?", "answer": "Build quality and materials are the most critical factors. Look for products made from premium materials with solid construction methods and backed by strong warranties."},
            ]

        html = build_html_section(article, internal_links, faqs)
        results[article["slug"]] = html

    # Output as JSON for consumption
    print(json.dumps(results, indent=2))

if __name__ == "__main__":
    main()
