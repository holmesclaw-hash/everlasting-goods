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
export type ReferralClass = "llm" | "organic" | "direct" | "referral";
export function classifyReferral(referrer: string): ReferralClass;
export function referralVisitEvent(
  referrer: string,
  pagePath: string
): {
  eventName: "referral_visit";
  parameters: {
    referral_class: ReferralClass;
    referral_host: string;
    page_path: string;
  };
};
