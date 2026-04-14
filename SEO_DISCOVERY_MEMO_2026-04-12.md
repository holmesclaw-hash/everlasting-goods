# Everlasting Goods discovery and internal linking memo

## What I audited
- Core public routes in `src/app`
- Global nav/footer crawl paths
- Hub, blog, product directory, category, and article templates
- Sitemap and robots implementation
- Data-backed article structure in `src/lib/data.ts`

## Safe improvements made
1. Fixed `next-sitemap.config.js` domain mismatch from `everlastinggoods.com` to `everlasting-goods.com`
2. Added explicit additional sitemap reference in `next-sitemap.config.js`
3. Strengthened `/blog` with a clear discovery box linking to the BIFL hub and product directory
4. Strengthened `/products` with a clear discovery box linking to the BIFL hub and all articles
5. Strengthened category pages with a discovery box linking back to the hub and all articles
6. Changed primary nav label from `BIFL Guide` to `Start Here` to make the hub more obviously central

## Top 10 highest-value remaining indexing/discovery improvements
1. **Add article-to-article contextual links programmatically**
   - Many articles already contain manual links, but coverage is uneven.
   - A reusable “related in this category” or “compare with” block near the top or mid-article would deepen crawl paths and reduce orphan-ish newer posts.

2. **Audit and fix broken internal article links in `src/lib/data.ts`**
   - Several articles reference slugs that may not exist.
   - This is high-value because broken internal links waste crawl equity and hurt trust.

3. **Add breadcrumb UI on page, not just JSON-LD**
   - Article pages already emit breadcrumb schema, but visible breadcrumbs would create more human-usable internal links.

4. **Create a richer category-to-hub and category-to-category layer**
   - Current category pages mostly list their own articles/products.
   - Add “related categories” links, for example Kitchen → Home, EDC → Outdoor, Tools → Home.

5. **Add a featured guides block to the homepage above or near latest articles**
   - Right now home favors recency.
   - A “start with these cornerstone guides” section would route users and crawlers toward the strongest evergreen pages.

6. **Build a lightweight HTML browse page by topic clusters beyond categories**
   - Example clusters: gifts, kitchen basics, repairable clothing, daily carry, home fixtures.
   - This helps discovery where category taxonomy is too broad.

7. **Normalize article heading IDs and table-of-contents coverage**
   - TOC extraction only works when article `<h2>` elements include explicit `id` attributes.
   - Many newer articles appear to lack them, so the TOC and anchor structure are inconsistent.

8. **Add canonical metadata to pages that currently rely only on defaults**
   - Home, products, about, privacy, terms, and contact should all have explicit canonical URLs for consistency.

9. **Create a dedicated all-categories page**
   - Categories currently exist in nav and filters, but not as a single browseable landing page.
   - That page would be a strong crawl hub.

10. **Review thin or generic legacy article sections**
   - A few articles still contain placeholder-style related reading (`href="#"`) or generic copy patterns.
   - Replace placeholders with real internal links and prune weak sections.

## Priority next actions
1. Run a repo-wide internal link integrity pass against article slugs and fix broken references.
2. Add visible breadcrumb navigation to article and category templates.
3. Add a small reusable “related guides” component to article pages, ideally above the fold or after intro.
4. Add a homepage evergreen/featured guides block.
5. Replace placeholder `#` related-reading links in legacy articles with real internal targets.

## Notes
- The site already has useful foundations: clean route structure, XML sitemap, robots route, category pages, article schema, FAQ schema, and a central hub.
- The biggest remaining upside is not more article volume. It is making existing pages easier to discover, traverse, and validate through stronger internal linking and cleaner crawl paths.
