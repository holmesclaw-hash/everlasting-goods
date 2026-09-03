"use client";

import { useEffect } from "react";
import {
  isAmazonAffiliateUrl,
  trackAffiliateClick,
} from "@/lib/analytics.mjs";
import { shouldTrackAffiliateClicks } from "@/lib/consent.mjs";

const CONSENT_KEY = "everlasting-goods-consent";

type AnalyticsWindow = Window & {
  gtag?: (...args: unknown[]) => void;
  everlastingGoodsAnalyticsDisabled?: boolean;
};

export default function AffiliateClickTracker() {
  useEffect(() => {
    const handleClick = (event: MouseEvent) => {
      if (!(event.target instanceof Element)) return;

      const anchor = event.target.closest<HTMLAnchorElement>("a[href]");
      if (!anchor || !isAmazonAffiliateUrl(anchor.href)) return;

      const analyticsWindow = window as AnalyticsWindow;
      if (!shouldTrackAffiliateClicks(
        window.localStorage.getItem(CONSENT_KEY),
        analyticsWindow.everlastingGoodsAnalyticsDisabled
      )) return;

      const gtag = analyticsWindow.gtag;
      if (typeof gtag !== "function") return;

      trackAffiliateClick(
        gtag,
        anchor.href,
        anchor.textContent ?? "",
        window.location.pathname,
        anchor.dataset.affiliatePlacement
      );
    };

    document.addEventListener("click", handleClick, { capture: true });
    return () => document.removeEventListener("click", handleClick, { capture: true });
  }, []);

  return null;
}
