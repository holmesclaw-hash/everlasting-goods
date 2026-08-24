"use client";

import Link from "next/link";
import Script from "next/script";
import { useEffect, useState } from "react";

import {
  consentFromStorage,
  performConsentWithdrawal,
  shouldLoadAds,
  shouldLoadAnalytics,
  type SiteConsent,
} from "@/lib/consent.mjs";

const CONSENT_KEY = "everlasting-goods-consent";
const ADS_ACCOUNT_READY = process.env.NEXT_PUBLIC_ADSENSE_ENABLED === "true";

type AnalyticsWindow = Window & {
  gtag?: (...args: unknown[]) => void;
  everlastingGoodsAnalyticsDisabled?: boolean;
};

export default function ConsentManager() {
  const [consent, setConsent] = useState<SiteConsent | null | undefined>(undefined);

  useEffect(() => {
    const frame = window.requestAnimationFrame(() => {
      setConsent(consentFromStorage(window.localStorage.getItem(CONSENT_KEY)));
    });
    return () => window.cancelAnimationFrame(frame);
  }, []);

  const saveConsent = (value: "accepted" | "rejected") => {
    window.localStorage.setItem(CONSENT_KEY, value);
    setConsent(consentFromStorage(value));
  };

  const resetConsent = () => {
    const analyticsWindow = window as AnalyticsWindow;
    performConsentWithdrawal({
      cookieHeader: document.cookie,
      hostname: window.location.hostname,
      disableTracking: () => {
        analyticsWindow.everlastingGoodsAnalyticsDisabled = true;
      },
      updateGoogleConsent: (...args) => {
        analyticsWindow.gtag?.(...args);
      },
      deleteCookie: (directive) => {
        document.cookie = directive;
      },
      clearStoredConsent: () => {
        window.localStorage.removeItem(CONSENT_KEY);
      },
      reload: () => window.location.reload(),
    });
  };

  const loadAnalytics = shouldLoadAnalytics(consent ?? null);
  const loadAds = shouldLoadAds(consent ?? null, ADS_ACCOUNT_READY);

  return (
    <>
      {loadAnalytics && (
        <>
          <Script
            src="https://www.googletagmanager.com/gtag/js?id=GT-MR86JNFG"
            strategy="afterInteractive"
          />
          <Script id="ga4-init" strategy="afterInteractive">
            {`window.dataLayer = window.dataLayer || []; function gtag(){dataLayer.push(arguments);} gtag('js', new Date()); gtag('config', 'GT-MR86JNFG', { anonymize_ip: true });`}
          </Script>
        </>
      )}

      {loadAds && (
        <Script
          src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-6903539486133095"
          strategy="lazyOnload"
          crossOrigin="anonymous"
        />
      )}

      {consent === null && (
        <div className="fixed inset-x-4 bottom-4 z-50 mx-auto max-w-3xl rounded-2xl border border-cream-200 bg-white p-5 shadow-2xl">
          <h2 className="font-serif text-lg font-bold text-charcoal">Optional cookies</h2>
          <p className="mt-2 text-sm text-charcoal/65 leading-relaxed">
            We use optional analytics to understand which durable-product guides are useful.
            Advertising remains disabled unless account and regional consent requirements are confirmed.
            See our <Link href="/privacy" className="text-forest-500 underline">privacy policy</Link>.
          </p>
          <div className="mt-4 flex flex-wrap gap-3">
            <button
              type="button"
              onClick={() => saveConsent("accepted")}
              className="rounded-lg bg-forest-500 px-5 py-2.5 text-sm font-medium text-white hover:bg-forest-600"
            >
              Accept optional cookies
            </button>
            <button
              type="button"
              onClick={() => saveConsent("rejected")}
              className="rounded-lg border border-cream-200 px-5 py-2.5 text-sm font-medium text-charcoal hover:bg-cream-100"
            >
              Reject optional cookies
            </button>
          </div>
        </div>
      )}

      {consent && (
        <button
          type="button"
          onClick={resetConsent}
          className="fixed bottom-3 right-3 z-40 rounded-full border border-cream-200 bg-white/95 px-3 py-1.5 text-xs text-charcoal/60 shadow-sm hover:text-charcoal"
        >
          Cookie settings
        </button>
      )}
    </>
  );
}
