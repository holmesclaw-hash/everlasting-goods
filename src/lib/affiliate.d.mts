export const AFFILIATE_TAG: string;
export function amazonLink(asin: string): string;
export function amazonSearchLink(query: string): string;
export function normalizeAmazonAffiliateUrl(value: string): string;
export function normalizeArticleAffiliateLinks(content: string): string;
