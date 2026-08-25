"use client";

import { useEffect } from "react";

import { referralVisitEvent } from "@/lib/analytics.mjs";
import { shouldTrackAffiliateClicks } from "@/lib/consent.mjs";

const CONSENT_KEY = "everlasting-goods-consent";

type AnalyticsWindow = Window & { gtag?: (...args: unknown[]) => void; everlastingGoodsAnalyticsDisabled?: boolean };

export default function ReferralTracker() {
  useEffect(() => {
    const analyticsWindow = window as AnalyticsWindow;
    if (!shouldTrackAffiliateClicks(window.localStorage.getItem(CONSENT_KEY), analyticsWindow.everlastingGoodsAnalyticsDisabled)) return;
    if (typeof analyticsWindow.gtag !== "function") return;
    const event = referralVisitEvent(document.referrer, window.location.pathname);
    analyticsWindow.gtag("event", event.eventName, event.parameters);
  }, []);
  return null;
}
