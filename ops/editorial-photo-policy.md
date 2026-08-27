# Exact-product article photo policy

Effective: 2026-08-27
Owner requirement: Daniel

## Publication requirement

Every new article must include at least one genuine photo of an exact product named in the article. For a top-five guide, the hero may feature any one of the exact listed models.

Generic category stock, lookalikes, and AI-generated product depictions do not qualify. Block publication when no lawful exact-product photo is available rather than substituting a generic image.

## Permitted rights bases

Use only:

1. an owned original;
2. a manufacturer or press asset with documented editorial-use permission;
3. an approved affiliate or API image used under its terms; or
4. a properly attributed open-license image.

Never scrape retailer or Amazon imagery outside an approved API or license path.

## Required provenance record

For every publishable article, record:

- exact product model;
- image file or approved remote URL;
- source URL;
- rights basis;
- creator attribution;
- license and license URL when applicable; and
- model-specific alt text.

The structured source of truth is `src/content/article-image-evidence.mjs`. A missing or incomplete record blocks publication.

## Existing-article maintenance

Prioritize high-intent, indexable articles first. Quarantined legacy articles remain blocked and do not justify downloading replacement images until their claims are independently rebuilt. Replacing a generic image does not make an unsupported article publishable.
