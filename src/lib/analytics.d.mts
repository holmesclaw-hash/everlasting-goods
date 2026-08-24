export function isAmazonAffiliateUrl(value: string): boolean;
export function affiliateClickEvent(
  value: string,
  linkText: string,
  pagePath: string
): {
  eventName: "affiliate_click";
  parameters: {
    affiliate_host: string;
    affiliate_path: string;
    link_text: string;
    page_path: string;
  };
};
export function trackAffiliateClick(
  gtag: (...args: unknown[]) => void,
  value: string,
  linkText: string,
  pagePath: string
): void;
