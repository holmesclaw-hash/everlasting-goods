export function isAmazonAffiliateUrl(value) {
  let url;
  try {
    url = new URL(value);
  } catch {
    return false;
  }

  const hostname = url.hostname.toLowerCase();
  const isAmazon = hostname === "amazon.com" || hostname.endsWith(".amazon.com");
  return url.protocol === "https:" && isAmazon;
}

export function affiliateClickEvent(value, linkText, pagePath, linkPlacement) {
  const url = new URL(value);
  return {
    eventName: "affiliate_click",
    parameters: {
      affiliate_host: url.hostname,
      affiliate_path: url.pathname,
      link_text: linkText.trim(),
      page_path: pagePath,
      ...(linkPlacement ? { link_placement: linkPlacement } : {}),
    },
  };
}

export function trackAffiliateClick(gtag, value, linkText, pagePath, linkPlacement) {
  const event = affiliateClickEvent(value, linkText, pagePath, linkPlacement);
  gtag("event", event.eventName, event.parameters);
}

const llmHosts = new Set([
  "chatgpt.com",
  "chat.openai.com",
  "claude.ai",
  "perplexity.ai",
  "gemini.google.com",
  "copilot.microsoft.com",
  "meta.ai",
  "you.com",
]);

const organicHosts = new Set([
  "google.com",
  "bing.com",
  "duckduckgo.com",
  "search.brave.com",
  "search.yahoo.com",
]);

function normalizedHost(value) {
  try {
    return new URL(value).hostname.toLowerCase().replace(/^www\./, "");
  } catch {
    return "";
  }
}

export function classifyReferral(referrer) {
  if (!referrer) return "direct";
  const host = normalizedHost(referrer);
  if (!host) return "direct";
  if (llmHosts.has(host)) return "llm";
  if (organicHosts.has(host)) return "organic";
  return "referral";
}

export function referralVisitEvent(referrer, pagePath) {
  return {
    eventName: "referral_visit",
    parameters: {
      referral_class: classifyReferral(referrer),
      referral_host: normalizedHost(referrer),
      page_path: pagePath,
    },
  };
}
