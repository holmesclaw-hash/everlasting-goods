import type { Metadata } from "next";
import { Playfair_Display, Inter } from "next/font/google";
import "./globals.css";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import AffiliateClickTracker from "@/components/AffiliateClickTracker";
import ReferralTracker from "@/components/ReferralTracker";
import ConsentManager from "@/components/ConsentManager";

const playfair = Playfair_Display({
  subsets: ["latin"],
  variable: "--font-playfair",
  display: "swap",
});

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
  display: "swap",
});

export const metadata: Metadata = {
  metadataBase: new URL("https://everlasting-goods.com"),
  title: {
    default: "Everlasting Goods — Repairability & Durability Database",
    template: "%s | Everlasting Goods",
  },
  description:
    "Evidence-tiered manufacturer documentation for repairability, warranty, parts support, serviceability, and true-cost analysis.",
  keywords: [
    "repairability database",
    "durable tools",
    "parts availability",
    "product warranty",
    "cost per year",
    "repair or replace",
  ],
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "https://everlasting-goods.com",
    siteName: "Everlasting Goods",
    title: "Everlasting Goods — Repairability & Durability Database",
    description:
      "Manufacturer-sourced product records with evidence tiers, verification dates, and explicit unknowns.",
    images: [
      {
        url: "/images/og-default.png",
        width: 1200,
        height: 630,
        alt: "Everlasting Goods repairability database",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Everlasting Goods — Repairability Database",
    description:
      "Evidence-tiered product records for repairability, durability, and true cost.",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className={`${playfair.variable} ${inter.variable}`}>
      <head>
        <meta name="google-site-verification" content="_Dfl-AtAcFZ0zYQN6G8KBjAbzoAPtTc67TuYa_GJSfo" />
      </head>
      <body className="font-sans bg-cream text-charcoal antialiased">
        <Header />
        <main className="min-h-screen">{children}</main>
        <Footer />
        <AffiliateClickTracker />
        <ReferralTracker />
        <ConsentManager />
      </body>
    </html>
  );
}
