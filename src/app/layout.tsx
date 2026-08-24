import type { Metadata } from "next";
import { Playfair_Display, Inter } from "next/font/google";
import "./globals.css";
import Header from "@/components/Header";
import Footer from "@/components/Footer";
import AffiliateClickTracker from "@/components/AffiliateClickTracker";
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
    default: "Everlasting Goods — Buy It For Life Product Reviews",
    template: "%s | Everlasting Goods",
  },
  description:
    "Evidence-led guides to durable, long-lasting products worth buying once. Quality gear that outlasts trends — kitchen, EDC, outdoor, clothing, tools & home.",
  keywords: [
    "buy it for life",
    "BIFL",
    "durable products",
    "product reviews",
    "long lasting",
    "quality gear",
  ],
  openGraph: {
    type: "website",
    locale: "en_US",
    url: "https://everlasting-goods.com",
    siteName: "Everlasting Goods",
    title: "Everlasting Goods — Buy It For Life Product Reviews",
    description:
      "Evidence-led guides to durable, long-lasting products worth buying once. Quality gear that outlasts trends.",
    images: [
      {
        url: "/images/og-default.png",
        width: 1200,
        height: 630,
        alt: "Everlasting Goods",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Everlasting Goods — Buy It For Life Product Reviews",
    description:
      "Evidence-led guides to durable, long-lasting products worth buying once.",
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
        <ConsentManager />
      </body>
    </html>
  );
}
