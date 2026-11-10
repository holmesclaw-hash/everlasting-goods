export function isAmazonAffiliateUrl(value: string): boolean;
export function affiliateClickEvent(
  value: string,
  linkText: string,
  pagePath: string,
  linkPlacement?: string
): {
  eventName: "affiliate_click";
  parameters: {
    affiliate_host: string;
    affiliate_path: string;
    link_text: string;
    page_path: string;
    link_placement?: string;
  };
};
export function trackAffiliateClick(
  gtag: (...args: unknown[]) => void,
  value: string,
  linkText: string,
  pagePath: string,
  linkPlacement?: string
): void;
export function internalLinkClickEvent(
  targetPath: string,
  linkText: string,
  pagePath: string,
  linkPlacement: string
): {
  eventName: "internal_link_click";
  parameters: {
    link_text: string;
    link_placement: string;
    page_path: string;
    target_path: string;
  };
};
export function trackInternalLinkClick(
  gtag: (...args: unknown[]) => void,
  targetPath: string,
  linkText: string,
  pagePath: string,
  linkPlacement: string
): void;
export function decisionToolCompletionEvent(
  toolName: string,
  outcomeStatus: string,
  pagePath: string,
  productSlug?: string
): {
  eventName: "decision_tool_complete";
  parameters: {
    tool_name: string;
    outcome_status: string;
    page_path: string;
    product_slug?: string;
  };
};
export function trackDecisionToolCompletion(
  gtag: (...args: unknown[]) => void,
  toolName: string,
  outcomeStatus: string,
  pagePath: string,
  productSlug?: string
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
