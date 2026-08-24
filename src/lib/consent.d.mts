export interface SiteConsent {
  analytics: boolean;
  advertising: boolean;
}
export interface ConsentWithdrawalActions {
  cookieHeader: string;
  hostname: string;
  disableTracking: () => void;
  updateGoogleConsent: (...args: unknown[]) => void;
  deleteCookie: (directive: string) => void;
  clearStoredConsent: () => void;
  reload: () => void;
}
export function consentFromStorage(value: string | null): SiteConsent | null;
export function shouldLoadAnalytics(consent: SiteConsent | null): boolean;
export function shouldLoadAds(consent: SiteConsent | null, adsAccountReady: boolean): boolean;
export function shouldTrackAffiliateClicks(
  storedConsent: string | null,
  trackingDisabled: boolean | undefined
): boolean;
export function performConsentWithdrawal(actions: ConsentWithdrawalActions): void;
