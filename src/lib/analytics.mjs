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

export function affiliateClickEvent(value, linkText, pagePath) {
  const url = new URL(value);
  return {
    eventName: "affiliate_click",
    parameters: {
      affiliate_host: url.hostname,
      affiliate_path: url.pathname,
      link_text: linkText.trim(),
      page_path: pagePath,
    },
  };
}

export function trackAffiliateClick(gtag, value, linkText, pagePath) {
  const event = affiliateClickEvent(value, linkText, pagePath);
  gtag("event", event.eventName, event.parameters);
}
