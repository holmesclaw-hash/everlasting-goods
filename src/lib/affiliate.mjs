export const AFFILIATE_TAG = "everlastin08f-20";

const AMAZON_HOSTS = new Set(["amazon.com", "www.amazon.com", "smile.amazon.com"]);

function isAmazonHostname(hostname) {
  const normalized = hostname.toLowerCase();
  return AMAZON_HOSTS.has(normalized) || normalized.endsWith(".amazon.com");
}

export function amazonLink(asin) {
  return normalizeAmazonAffiliateUrl(`https://www.amazon.com/dp/${asin}`);
}

export function amazonSearchLink(query) {
  const url = new URL("https://www.amazon.com/s");
  url.searchParams.set("k", query);
  url.searchParams.set("tag", AFFILIATE_TAG);
  return url.toString();
}

export function normalizeAmazonAffiliateUrl(value) {
  let url;
  try {
    url = new URL(value);
  } catch {
    return value;
  }

  if (url.protocol !== "https:" || !isAmazonHostname(url.hostname)) {
    return value;
  }

  url.searchParams.set("tag", AFFILIATE_TAG);
  return url.toString();
}

export function normalizeArticleAffiliateLinks(content) {
  return content.replace(/<a\b[^>]*>/gi, (openingTag) => {
    const hrefMatch = openingTag.match(/\bhref=(["'])(https:\/\/[^"'\s>]+)\1/i);
    if (!hrefMatch) return openingTag;

    let parsed;
    try {
      parsed = new URL(hrefMatch[2]);
    } catch {
      return openingTag;
    }
    if (!isAmazonHostname(parsed.hostname)) return openingTag;

    const hrefQuote = hrefMatch[1];
    let normalizedTag = openingTag.replace(
      hrefMatch[0],
      `href=${hrefQuote}${normalizeAmazonAffiliateUrl(hrefMatch[2])}${hrefQuote}`
    );

    const relValue = "sponsored nofollow noopener noreferrer";
    const relMatch = normalizedTag.match(/\brel=(["'])[^"']*\1/i);
    if (relMatch) {
      normalizedTag = normalizedTag.replace(
        relMatch[0],
        `rel=${relMatch[1]}${relValue}${relMatch[1]}`
      );
    } else {
      normalizedTag = normalizedTag.replace(/>$/, ` rel="${relValue}">`);
    }

    return normalizedTag;
  });
}
