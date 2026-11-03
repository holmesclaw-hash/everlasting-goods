"use client";

import { useEffect } from "react";
import { trackInternalLinkClick } from "@/lib/analytics.mjs";
import { shouldTrackAffiliateClicks } from "@/lib/consent.mjs";

const CONSENT_KEY = "everlasting-goods-consent";

type AnalyticsWindow = Window & {
  gtag?: (...args: unknown[]) => void;
  everlastingGoodsAnalyticsDisabled?: boolean;
};

export default function InternalLinkClickTracker() {
  useEffect(() => {
    const handleClick = (event: MouseEvent) => {
      if (!(event.target instanceof Element)) return;

      const anchor = event.target.closest<HTMLAnchorElement>("a[data-internal-placement][href]");
      if (!anchor) return;

      const placement = anchor.dataset.internalPlacement;
      if (!placement) return;

      const targetUrl = new URL(anchor.href);
      if (targetUrl.origin !== window.location.origin) return;

      const analyticsWindow = window as AnalyticsWindow;
      if (!shouldTrackAffiliateClicks(
        window.localStorage.getItem(CONSENT_KEY),
        analyticsWindow.everlastingGoodsAnalyticsDisabled
      )) return;

      const gtag = analyticsWindow.gtag;
      if (typeof gtag !== "function") return;

      trackInternalLinkClick(
        gtag,
        `${targetUrl.pathname}${targetUrl.search}`,
        anchor.textContent ?? "",
        window.location.pathname,
        placement
      );
    };

    document.addEventListener("click", handleClick, { capture: true });
    return () => document.removeEventListener("click", handleClick, { capture: true });
  }, []);

  return null;
}
