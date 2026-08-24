import assert from "node:assert/strict";
import test from "node:test";

import {
  consentFromStorage,
  performConsentWithdrawal,
  shouldLoadAds,
  shouldLoadAnalytics,
  shouldTrackAffiliateClicks,
} from "../src/lib/consent.mjs";

test("defaults optional analytics and advertising to off", () => {
  assert.equal(consentFromStorage(null), null);
  assert.equal(shouldLoadAnalytics(null), false);
  assert.equal(shouldLoadAds(null, true), false);
});

test("loads analytics only after explicit acceptance", () => {
  const consent = consentFromStorage("accepted");
  assert.deepEqual(consent, { analytics: true, advertising: true });
  assert.equal(shouldLoadAnalytics(consent), true);
});

test("keeps AdSense disabled until both consent and account-side approval exist", () => {
  const consent = consentFromStorage("accepted");
  assert.equal(shouldLoadAds(consent, false), false);
  assert.equal(shouldLoadAds(consent, true), true);
  assert.equal(shouldLoadAds(consentFromStorage("rejected"), true), false);
});

test("rejects unknown stored consent values", () => {
  assert.equal(consentFromStorage("unexpected"), null);
});

test("affiliate events require accepted consent and stop immediately on withdrawal", () => {
  assert.equal(shouldTrackAffiliateClicks("accepted", false), true);
  assert.equal(shouldTrackAffiliateClicks("accepted", true), false);
  assert.equal(shouldTrackAffiliateClicks("rejected", false), false);
  assert.equal(shouldTrackAffiliateClicks(null, false), false);
});

test("withdrawal disables tracking, denies Google consent, removes measurement cookies, clears storage, then reloads", () => {
  const actions = [];

  performConsentWithdrawal({
    cookieHeader: "session=keep; _ga=GA1.1.123.456; _ga_MR86JNFG=GS1.1.123; _gid=GA1.2.123.456",
    hostname: "www.everlasting-goods.com",
    disableTracking: () => actions.push("tracking-disabled"),
    updateGoogleConsent: (...args) => actions.push(["google-consent", ...args]),
    deleteCookie: (directive) => actions.push(["delete-cookie", directive]),
    clearStoredConsent: () => actions.push("storage-cleared"),
    reload: () => actions.push("reloaded"),
  });

  assert.equal(actions[0], "tracking-disabled");
  assert.deepEqual(actions[1], [
    "google-consent",
    "consent",
    "update",
    {
      analytics_storage: "denied",
      ad_storage: "denied",
      ad_user_data: "denied",
      ad_personalization: "denied",
    },
  ]);

  const cookieActions = actions.filter(
    (action) => Array.isArray(action) && action[0] === "delete-cookie"
  );
  assert.ok(cookieActions.length > 0);
  assert.ok(cookieActions.every(([, directive]) => !directive.startsWith("session=")));
  assert.ok(cookieActions.some(([, directive]) => directive.startsWith("_ga=")));
  assert.ok(cookieActions.some(([, directive]) => directive.startsWith("_ga_MR86JNFG=")));
  assert.ok(cookieActions.some(([, directive]) => directive.startsWith("_gid=")));
  assert.ok(cookieActions.some(([, directive]) => directive.includes("Domain=.everlasting-goods.com")));
  assert.deepEqual(actions.slice(-2), ["storage-cleared", "reloaded"]);
});
