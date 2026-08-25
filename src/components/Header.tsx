"use client";

import Link from "next/link";
import { useState } from "react";

const links = [
  ["Database", "/database"],
  ["Products", "/products"],
  ["Cost per year", "/tools/cost-per-year"],
  ["Repair or replace", "/tools/repair-or-replace"],
  ["Methodology", "/methodology"],
  ["About", "/about"],
] as const;

export default function Header() {
  const [mobileOpen, setMobileOpen] = useState(false);
  return <header className="sticky top-0 z-50 border-b border-cream-200 bg-white/90 backdrop-blur-md"><div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-4 sm:px-6 lg:h-20 lg:px-8"><Link href="/" className="flex items-center gap-2"><div className="flex h-8 w-8 items-center justify-center rounded-full bg-forest-500 text-sm font-bold text-white">E</div><div><span className="block font-serif text-lg font-bold text-charcoal">Everlasting Goods</span><span className="hidden text-[10px] font-semibold uppercase tracking-[0.18em] text-brown-accent sm:block">Repairability database</span></div></Link><nav className="hidden items-center gap-6 lg:flex">{links.map(([label, href]) => <Link key={href} href={href} className="text-sm font-semibold text-charcoal/65 hover:text-forest-600">{label}</Link>)}</nav><button onClick={() => setMobileOpen(!mobileOpen)} className="p-2 text-charcoal lg:hidden" aria-label="Toggle menu">{mobileOpen ? "Close" : "Menu"}</button></div>{mobileOpen && <div className="border-t border-cream-200 bg-white px-4 py-3 lg:hidden">{links.map(([label, href]) => <Link key={href} href={href} onClick={() => setMobileOpen(false)} className="block rounded-lg px-3 py-2.5 text-sm font-semibold text-charcoal/70 hover:bg-cream-100">{label}</Link>)}</div>}</header>;
}
