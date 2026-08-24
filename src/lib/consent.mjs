export function consentFromStorage(value) {
  if (value === "accepted") return { analytics: true, advertising: true };
  if (value === "rejected") return { analytics: false, advertising: false };
  return null;
}

export function shouldLoadAnalytics(consent) {
  return consent?.analytics === true;
}

export function shouldLoadAds(consent, adsAccountReady) {
  return consent?.advertising === true && adsAccountReady === true;
}

export function shouldTrackAffiliateClicks(storedConsent, trackingDisabled) {
  return trackingDisabled !== true && shouldLoadAnalytics(consentFromStorage(storedConsent));
}

const GOOGLE_CONSENT_DENIED = Object.freeze({
  analytics_storage: "denied",
  ad_storage: "denied",
  ad_user_data: "denied",
  ad_personalization: "denied",
});

function isGoogleMeasurementCookie(name) {
  return /^(?:_ga(?:_.+)?|_gid|_gat(?:_.+)?|_gac_.+|_gcl_au)$/.test(name);
}

function cookieDeletionDirectives(cookieHeader, hostname) {
  const names = cookieHeader
    .split(";")
    .map((cookie) => cookie.trim().split("=", 1)[0])
    .filter(isGoogleMeasurementCookie);
  const domainParts = hostname.toLowerCase().replace(/^\.|\.$/g, "").split(".");
  const siteDomain = domainParts.length >= 2
    ? `.${domainParts.slice(-2).join(".")}`
    : null;

  return names.flatMap((name) => {
    const base = `${name}=; Expires=Thu, 01 Jan 1970 00:00:00 GMT; Max-Age=0; Path=/; SameSite=Lax`;
    return siteDomain ? [base, `${base}; Domain=${siteDomain}`] : [base];
  });
}

export function performConsentWithdrawal({
  cookieHeader,
  hostname,
  disableTracking,
  updateGoogleConsent,
  deleteCookie,
  clearStoredConsent,
  reload,
}) {
  disableTracking();
  updateGoogleConsent("consent", "update", GOOGLE_CONSENT_DENIED);
  for (const directive of cookieDeletionDirectives(cookieHeader, hostname)) {
    deleteCookie(directive);
  }
  clearStoredConsent();
  reload();
}
