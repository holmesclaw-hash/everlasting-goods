export interface Category {
  slug: string;
  name: string;
  description: string;
  icon: string;
  image: string;
}

export interface Product {
  slug: string;
  name: string;
  brand: string;
  category: string;
  price: string;
  rating: number;
  image: string;
  description: string;
  affiliateUrl: string;
  features: string[];
}

export interface Article {
  slug: string;
  title: string;
  excerpt: string;
  category: string;
  image: string;
  author: string;
  date: string;
  readTime: string;
  featured: boolean;
  products: string[];
  content: string;
}

const AFFILIATE_TAG = "everlastin09f-20";

function amazonLink(asin: string): string {
  return `https://www.amazon.com/dp/${asin}?tag=${AFFILIATE_TAG}`;
}

export const categories: Category[] = [
  {
    slug: "kitchen",
    name: "Kitchen",
    description:
      "Cookware, knives, and kitchen tools built to last generations.",
    icon: "🍳",
    image: "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=600&h=400&fit=crop",
  },
  {
    slug: "edc",
    name: "EDC",
    description:
      "Everyday carry gear — flashlights, knives, wallets, and tools you can rely on.",
    icon: "🔦",
    image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&h=400&fit=crop",
  },
  {
    slug: "outdoor",
    name: "Outdoor",
    description:
      "Backpacks, camping gear, and outdoor equipment that survives the elements.",
    icon: "🏔️",
    image: "https://images.unsplash.com/photo-1501555088652-021faa106b9b?w=600&h=400&fit=crop",
  },
  {
    slug: "clothing",
    name: "Clothing",
    description:
      "Boots, jackets, and garments crafted for decades of wear.",
    icon: "👢",
    image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&h=400&fit=crop",
  },
  {
    slug: "tools",
    name: "Tools",
    description:
      "Hand tools, power tools, and workshop essentials built for a lifetime.",
    icon: "🔧",
    image: "https://images.unsplash.com/photo-1581783898377-1c85bf937427?w=600&h=400&fit=crop",
  },
  {
    slug: "home",
    name: "Home",
    description:
      "Furniture, appliances, and home goods that stand the test of time.",
    icon: "🏠",
    image: "https://images.unsplash.com/photo-1556909114-44e3e70034e2?w=600&h=400&fit=crop",
  },
];

export const products: Product[] = [
  {
    slug: "lodge-cast-iron-skillet",
    name: "Lodge 12-Inch Cast Iron Skillet",
    brand: "Lodge",
    category: "kitchen",
    price: "$29.90",
    rating: 4.8,
    image: "https://images.unsplash.com/photo-1585442133735-1ab2e3f68668?w=600&h=400&fit=crop",
    description:
      "Pre-seasoned and ready to use right out of the box. Lodge has been making cast iron in Tennessee since 1896. This skillet will outlive you — and your grandchildren will fight over it.",
    affiliateUrl: amazonLink("B00006JSUA"),
    features: [
      "Pre-seasoned with vegetable oil",
      "Made in South Pittsburg, Tennessee since 1896",
      "Unparalleled heat retention and even heating",
      "Oven safe to any temperature",
      "Lifetime warranty",
    ],
  },
  {
    slug: "goruck-gr1",
    name: "GORUCK GR1 26L",
    brand: "GORUCK",
    category: "outdoor",
    price: "$395.00",
    rating: 4.9,
    image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&h=400&fit=crop",
    description:
      "Built by Green Berets in the USA from 1000D Cordura. The GR1 is the gold standard for a buy-it-for-life backpack. Military-grade construction meets clean, urban design.",
    affiliateUrl: amazonLink("B01N1URQBP"),
    features: [
      "1000D Cordura nylon — virtually indestructible",
      "YKK zippers with silent pull cords",
      "Bombproof laptop compartment",
      "Made in the USA",
      "Lifetime SCARS warranty",
    ],
  },
  {
    slug: "red-wing-iron-ranger",
    name: "Red Wing Iron Ranger 8111",
    brand: "Red Wing",
    category: "clothing",
    price: "$339.99",
    rating: 4.7,
    image: "https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=600&h=400&fit=crop",
    description:
      "Amber Harness leather, Vibram mini-lug outsole, triple-stitched quality. These boots are built to be resoled and worn for 20+ years. They only get better with age.",
    affiliateUrl: amazonLink("B001IOEQH8"),
    features: [
      "Premium Amber Harness leather",
      "Vibram 430 mini-lug outsole",
      "Goodyear welt construction — fully resoleable",
      "Made in Red Wing, Minnesota",
      "Triple-stitched for durability",
    ],
  },
  {
    slug: "victorinox-fibrox-chef-knife",
    name: "Victorinox Fibrox Pro 8\" Chef's Knife",
    brand: "Victorinox",
    category: "kitchen",
    price: "$36.75",
    rating: 4.8,
    image: "https://images.unsplash.com/photo-1593618998160-e34014e67546?w=600&h=400&fit=crop",
    description:
      "The best chef's knife for 90% of home cooks. Razor-sharp out of the box, easy to maintain, perfectly balanced. Recommended by America's Test Kitchen for over a decade.",
    affiliateUrl: amazonLink("B008M5U1C2"),
    features: [
      "High-carbon stainless steel blade",
      "Fibrox Pro handle — slip-resistant even when wet",
      "Laser-tested edge for sharpness",
      "NSF certified",
      "Lifetime warranty against defects",
    ],
  },
  {
    slug: "surefire-edc-flashlight",
    name: "SureFire EDC1-DFT Flashlight",
    brand: "SureFire",
    category: "edc",
    price: "$169.00",
    rating: 4.6,
    image: "https://images.unsplash.com/photo-1567186937-efc3150e4098?w=600&h=400&fit=crop",
    description:
      "Machined from aerospace aluminum, dual-fuel compatible, and virtually indestructible. SureFire has been the go-to for military and law enforcement for decades. This is the flashlight you buy once.",
    affiliateUrl: amazonLink("B09M8WYN9X"),
    features: [
      "Aerospace-grade aluminum body",
      "650 lumens max output",
      "Dual-fuel: rechargeable or CR123A",
      "IPX8 water resistant",
      "No-hassle lifetime warranty",
    ],
  },
  {
    slug: "darn-tough-socks",
    name: "Darn Tough Hiker Micro Crew",
    brand: "Darn Tough",
    category: "clothing",
    price: "$26.00",
    rating: 4.9,
    image: "https://images.unsplash.com/photo-1586350977771-b3b0abd50c82?w=600&h=400&fit=crop",
    description:
      "Made in Vermont from premium Merino wool. The unconditional lifetime warranty says it all — if these socks ever wear out, Darn Tough replaces them. No questions asked.",
    affiliateUrl: amazonLink("B074CJN4BH"),
    features: [
      "Fine-gauge Merino wool blend",
      "Made in Northfield, Vermont",
      "Unconditional lifetime warranty",
      "Moisture-wicking and temperature regulating",
      "True seamless construction",
    ],
  },
];

export const articles: Article[] = [
  {
    slug: "best-cast-iron-skillets-that-last-forever",
    title: "Best Cast Iron Skillets That Last Forever",
    excerpt:
      "A well-seasoned cast iron skillet is the ultimate buy-it-for-life kitchen essential. We tested and reviewed the best options for 2024.",
    category: "kitchen",
    image: "https://images.unsplash.com/photo-1585442133735-1ab2e3f68668?w=800&h=500&fit=crop",
    author: "James Chen",
    date: "2024-11-15",
    readTime: "12 min read",
    featured: true,
    products: ["lodge-cast-iron-skillet", "victorinox-fibrox-chef-knife"],
    content: `
<h2 id="why-cast-iron">Why Cast Iron Is the Ultimate BIFL Cookware</h2>
<p>There's a reason your grandmother's cast iron skillet is still going strong after 60 years. Cast iron is, quite simply, the most durable cookware material on earth. When properly cared for, a cast iron skillet will last not just your lifetime, but your children's and grandchildren's too.</p>
<p>Unlike non-stick pans that degrade after a few years, or stainless steel that can warp, cast iron actually <strong>gets better with age</strong>. Every time you cook with it, you're building up the seasoning — that slick, natural non-stick surface that makes cast iron such a joy to use.</p>

<h2 id="our-top-pick">Our Top Pick: Lodge 12-Inch Skillet</h2>
<p>After testing over a dozen cast iron skillets, the Lodge 12-Inch remains our top recommendation. At under $30, it's an absurd value for something that will last forever. Lodge has been pouring iron in South Pittsburg, Tennessee since 1896, and their quality control is impeccable.</p>
<p>The skillet comes pre-seasoned with vegetable oil, so it's ready to use right out of the box. The heat retention is outstanding — once this thing gets hot, it stays hot. Perfect for searing steaks, baking cornbread, or making the crispiest fried eggs you've ever had.</p>
<ul>
<li><strong>Weight:</strong> 8 lbs — hefty, but that mass is what gives you even heating</li>
<li><strong>Handle:</strong> Integrated cast iron with a helper handle opposite</li>
<li><strong>Oven safe:</strong> To any temperature your oven can reach</li>
<li><strong>Made in USA:</strong> South Pittsburg, Tennessee since 1896</li>
</ul>

<h2 id="how-to-care">How to Care for Cast Iron</h2>
<p>The biggest myth about cast iron is that it's hard to maintain. It's not. Here's the simple truth: cook with it often, clean it promptly, and dry it thoroughly. That's 90% of cast iron care.</p>
<p>After cooking, rinse with hot water and use a chain mail scrubber or stiff brush to remove food. Dry immediately and completely — water is cast iron's only real enemy. Apply a thin coat of oil while the pan is still warm.</p>
<p>And yes, you can use soap occasionally. Modern dish soap won't strip a well-built seasoning layer. That's an old wives' tale from when soap contained lye.</p>

<h2 id="runner-up">Runner Up: Le Creuset Signature Skillet</h2>
<p>If budget isn't a concern, the Le Creuset enameled cast iron skillet is a beautiful option. The enamel coating means you don't need to worry about seasoning, and it comes in a rainbow of gorgeous colors. At $200+, it's a premium choice, but Le Creuset's lifetime warranty backs it up.</p>

<h2 id="verdict">The Verdict</h2>
<p>You can spend $30 on a Lodge that will literally last forever, or you can keep buying cheap non-stick pans every 2-3 years. The math is simple, and so is the choice. A cast iron skillet isn't just a kitchen tool — it's an heirloom.</p>
    `,
  },
  {
    slug: "best-buy-it-for-life-backpacks",
    title: "Best Buy It For Life Backpacks",
    excerpt:
      "From GORUCK to Filson, we tested the most durable backpacks money can buy. These packs are built to survive decades of daily use.",
    category: "outdoor",
    image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&h=500&fit=crop",
    author: "Sarah Mitchell",
    date: "2024-10-28",
    readTime: "15 min read",
    featured: true,
    products: ["goruck-gr1"],
    content: `
<h2 id="what-makes-bifl">What Makes a Backpack BIFL?</h2>
<p>A buy-it-for-life backpack isn't just durable — it's thoughtfully designed, well-constructed, and backed by a warranty that means something. We looked at five key factors: material quality, construction method, zipper and hardware quality, warranty, and real-world longevity reports.</p>
<p>The difference between a $50 backpack and a $300+ BIFL pack is enormous. Cheap packs use 300-600D polyester, lightweight zippers, and bar-tack stitching at stress points. BIFL packs use 1000D Cordura or waxed canvas, YKK zippers, and are reinforced far beyond what you'd expect.</p>

<h2 id="top-pick-goruck">Top Pick: GORUCK GR1</h2>
<p>The GORUCK GR1 is, in our opinion, the best buy-it-for-life backpack you can get. Designed by a Green Beret and built in the USA, it's made from 1000D Cordura nylon — the same material used in military gear. We've seen GR1s with 10+ years of daily use that still look nearly new.</p>
<p>The design is deceptively simple: one main compartment with a bombproof laptop sleeve, a front slant pocket, and internal MOLLE webbing for organization. The YKK zippers are smooth and reliable, with 550 paracord pulls that double as emergency cordage.</p>
<ul>
<li><strong>Material:</strong> 1000D Cordura nylon</li>
<li><strong>Capacity:</strong> 26 liters</li>
<li><strong>Laptop:</strong> Fits up to 16" with padded false-bottom protection</li>
<li><strong>Warranty:</strong> Lifetime SCARS warranty — they'll repair anything</li>
</ul>

<h2 id="runner-up-filson">Runner Up: Filson Journeyman</h2>
<p>For those who prefer waxed canvas over Cordura, the Filson Journeyman is an exceptional choice. Made in Seattle from tin cloth and bridle leather, it has a heritage look that ages beautifully. Filson's been making rugged gear since the Klondike Gold Rush, and their warranty is ironclad.</p>

<h2 id="budget-pick">Budget Pick: Osprey Daylite Plus</h2>
<p>At under $100, the Osprey Daylite Plus offers remarkable durability for the price. While it won't match the GR1 in materials, Osprey's All Mighty Guarantee means they'll repair any product, for any reason, for free. That's a BIFL warranty on a budget-friendly pack.</p>

<h2 id="verdict">Our Verdict</h2>
<p>The GORUCK GR1 is an investment, but it's the last backpack you'll ever need to buy. The combination of military-grade materials, clean design, and an incredible warranty makes it the gold standard for buy-it-for-life packs.</p>
    `,
  },
  {
    slug: "best-kitchen-knives-that-last-a-lifetime",
    title: "Best Kitchen Knives That Last a Lifetime",
    excerpt:
      "A great chef's knife is the most important tool in your kitchen. These knives are built to perform for decades with proper care.",
    category: "kitchen",
    image: "https://images.unsplash.com/photo-1593618998160-e34014e67546?w=800&h=500&fit=crop",
    author: "James Chen",
    date: "2024-10-10",
    readTime: "14 min read",
    featured: true,
    products: ["victorinox-fibrox-chef-knife"],
    content: `
<h2 id="one-great-knife">Why You Only Need One Great Knife</h2>
<p>Here's a secret that professional chefs know: you don't need a drawer full of knives. One excellent 8-inch chef's knife will handle 90% of everything you do in the kitchen. From mincing garlic to breaking down a chicken, a good chef's knife is the most versatile tool you own.</p>
<p>The key is buying a knife that's well-made, comfortable in your hand, and easy to maintain. A BIFL knife doesn't have to cost $300 — in fact, our top pick is under $40.</p>

<h2 id="best-value">Best Value: Victorinox Fibrox Pro 8"</h2>
<p>The Victorinox Fibrox Pro has been the top-rated chef's knife at America's Test Kitchen for over a decade, and for good reason. At under $40, it outperforms knives costing five times as much. The high-carbon stainless steel blade takes a razor edge and is easy to sharpen.</p>
<p>The Fibrox handle is comfortable even during long prep sessions and stays grippy even when wet. It's not the most beautiful knife — the plastic handle won't win design awards — but in terms of pure performance and durability per dollar, nothing comes close.</p>
<ul>
<li><strong>Blade:</strong> High-carbon stainless steel</li>
<li><strong>Length:</strong> 8 inches (also available in 6" and 10")</li>
<li><strong>Handle:</strong> Fibrox Pro — textured, slip-resistant</li>
<li><strong>Edge:</strong> Laser-tested for sharpness</li>
<li><strong>Warranty:</strong> Lifetime against defects</li>
</ul>

<h2 id="premium-pick">Premium Pick: Wüsthof Classic 8"</h2>
<p>If you want a knife that performs beautifully and looks the part, the Wüsthof Classic is the answer. Forged in Solingen, Germany from a single piece of high-carbon steel, it has perfect balance and a gorgeous full-tang design. At around $150, it's an investment, but one you'll be using 30 years from now.</p>

<h2 id="maintenance">Keeping Your Knives Sharp</h2>
<p>The most important thing you can do for your knives is keep them sharp. A dull knife is more dangerous than a sharp one because it requires more force, making slips more likely. Invest in a quality whetstone or take your knives to a professional sharpener once or twice a year.</p>
<p>Between sharpenings, use a honing steel before each use. This doesn't actually sharpen the blade — it realigns the microscopic edge, keeping it cutting smoothly. And please, never put a good knife in the dishwasher. Hand wash, dry immediately, done.</p>

<h2 id="verdict">The Bottom Line</h2>
<p>The Victorinox Fibrox Pro is the best chef's knife for the vast majority of home cooks. It's incredibly sharp, easy to maintain, and costs less than a decent dinner out. Buy it, learn to hone it, and it'll serve you faithfully for decades.</p>
    `,
  },
  {
    slug: "best-leather-boots-that-last-20-years",
    title: "Best Leather Boots That Last 20+ Years",
    excerpt:
      "Invest in a pair of quality leather boots and you'll never look back. These boots are built to be resoled and worn for decades.",
    category: "clothing",
    image: "https://images.unsplash.com/photo-1638247025967-b4e38f787b76?w=800&h=500&fit=crop",
    author: "Marcus Rivera",
    date: "2024-09-22",
    readTime: "16 min read",
    featured: false,
    products: ["red-wing-iron-ranger", "darn-tough-socks"],
    content: `
<h2 id="why-quality-boots">Why Quality Boots Are the Best Investment in Your Wardrobe</h2>
<p>Here's the math: a $60 pair of boots lasts 1-2 years. Over 20 years, that's $600-$1,200 on boots that never look great and hurt your feet. A $340 pair of Red Wing Iron Rangers lasts 20+ years with one or two resolings (~$100 each). Total cost: $440-$540 for boots that look better every year.</p>
<p>But it's not just about money. Quality leather boots break in to the exact shape of your feet. After the first few weeks (yes, the break-in is real), they become the most comfortable shoes you own. They develop a patina that tells your story. They're <em>yours</em> in a way that disposable footwear can never be.</p>

<h2 id="top-pick">Top Pick: Red Wing Iron Ranger 8111</h2>
<p>The Red Wing Iron Ranger is the quintessential buy-it-for-life boot. Made in Red Wing, Minnesota from Amber Harness leather, with a Goodyear welt that allows for easy resoling. The triple-stitched construction and Vibram mini-lug outsole make these boots nearly indestructible.</p>
<p>The break-in period is legendary — expect 2-3 weeks of discomfort before the leather molds to your feet. After that, you'll understand why people are so passionate about these boots. The Amber Harness leather develops an incredible patina over time, and each pair tells a unique story.</p>
<ul>
<li><strong>Leather:</strong> Amber Harness — S.B. Foot Tanning Co.</li>
<li><strong>Construction:</strong> Goodyear welt — fully resoleable</li>
<li><strong>Sole:</strong> Vibram 430 mini-lug</li>
<li><strong>Made in:</strong> Red Wing, Minnesota</li>
<li><strong>Break-in:</strong> 2-3 weeks — be patient, it's worth it</li>
</ul>

<h2 id="pair-with">Pair With: Darn Tough Socks</h2>
<p>Quality boots deserve quality socks. Darn Tough's Merino wool hiking socks are the perfect complement to your Iron Rangers. They regulate temperature, wick moisture, and come with an unconditional lifetime warranty. If they ever wear out, Darn Tough replaces them free.</p>

<h2 id="care-tips">Boot Care Basics</h2>
<p>Taking care of quality leather boots is simple but important. Clean them with a horsehair brush after wearing. Condition the leather every 2-3 months with a quality conditioner like Bick 4 or Red Wing's own boot cream. If they get soaked, stuff them with newspaper and let them dry naturally — never use heat.</p>
<p>When the soles wear down (usually after 3-5 years of heavy use), send them back to Red Wing or a quality cobbler for a resole. It costs around $100 and gives you what feels like a brand new pair of boots.</p>

<h2 id="verdict">Worth Every Penny</h2>
<p>The Red Wing Iron Ranger isn't cheap. But over its 20+ year lifespan, it's one of the most cost-effective purchases you can make. These are boots with soul — literally and figuratively. Buy them, break them in, and they'll reward you with decades of service.</p>
    `,
  },
  {
    slug: "best-edc-flashlights-that-last-forever",
    title: "Best EDC Flashlights That Last Forever",
    excerpt:
      "A quality flashlight is one of the most practical EDC items you can carry. These lights are built to survive anything.",
    category: "edc",
    image: "https://images.unsplash.com/photo-1567186937-efc3150e4098?w=800&h=500&fit=crop",
    author: "Alex Nakamura",
    date: "2024-09-05",
    readTime: "11 min read",
    featured: false,
    products: ["surefire-edc-flashlight"],
    content: `
<h2 id="why-carry">Why Every Person Should Carry a Flashlight</h2>
<p>Your phone has a flashlight, sure. But it drains your battery, it's not very bright, and try holding your phone in your mouth while you need both hands free. A dedicated EDC flashlight is brighter, more durable, more ergonomic, and always ready when you need it.</p>
<p>Whether it's finding your car in a dark parking lot, checking under furniture, navigating a power outage, or signaling for help, a good flashlight earns its pocket space every single day.</p>

<h2 id="top-pick">Top Pick: SureFire EDC1-DFT</h2>
<p>SureFire has been the gold standard in tactical lighting for decades. Their EDC1-DFT is a pocket-sized powerhouse: 650 lumens from a body machined from aerospace-grade aluminum. It's rated IPX8 for water resistance and has been drop-tested to military specifications.</p>
<p>The dual-fuel capability is a standout feature — run it on a rechargeable 18650 battery for daily use, or swap in a CR123A lithium cell when you need guaranteed shelf-stable power. The beam profile is clean and usable, with a good balance of throw and flood.</p>
<ul>
<li><strong>Output:</strong> 5 / 650 lumens (low/high)</li>
<li><strong>Battery:</strong> Dual-fuel — 18650 rechargeable or CR123A</li>
<li><strong>Material:</strong> Aerospace-grade aluminum</li>
<li><strong>Water resistance:</strong> IPX8</li>
<li><strong>Warranty:</strong> No-hassle lifetime warranty</li>
</ul>

<h2 id="budget-pick">Budget Pick: Fenix E18R V2.0</h2>
<p>At around $60, the Fenix E18R V2.0 punches well above its weight. 1200 lumens from a tiny body, USB-C charging, and an IP68 rating. Fenix's build quality is excellent, and while it's not quite SureFire-level, it's the best value in EDC flashlights by a wide margin.</p>

<h2 id="what-to-look-for">What to Look For in an EDC Flashlight</h2>
<p>The best EDC flashlight is the one you actually carry. That means size and weight matter as much as lumens. Look for a light that fits comfortably in your pocket with a good clip. Two brightness modes is the sweet spot — a low mode for close-up tasks and a high mode for distance.</p>
<p>Build quality matters most for longevity. Look for machined (not cast) aluminum, proper O-ring seals, and quality switches. The switch is usually the first thing to fail on a cheap flashlight, so pay attention to reviews about switch reliability.</p>

<h2 id="verdict">Light Up Your Life</h2>
<p>A quality EDC flashlight is a small investment that pays dividends every day. The SureFire EDC1-DFT is our top pick for its unmatched build quality and lifetime warranty, but even the budget-friendly Fenix will serve you well for years to come. Either way, once you start carrying a flashlight, you'll wonder how you ever got by without one.</p>
    `,
  },
  {
    slug: "best-dutch-ovens-that-last-forever",
    title: "Best Dutch Ovens That Last Forever",
    excerpt:
      "A quality Dutch oven is a kitchen investment that pays dividends for generations. From Le Creuset to Lodge, these are the pots worth buying once and passing down.",
    category: "kitchen",
    image: "https://images.unsplash.com/photo-1556909172-54557c7e4fb7?w=800&h=500&fit=crop",
    author: "James Chen",
    date: "2026-04-03",
    readTime: "14 min read",
    featured: false,
    products: ["lodge-cast-iron-skillet"],
    content: `
<h2 id="why-dutch-oven">Why a Dutch Oven Is a BIFL Essential</h2>
<p>Most kitchen gear is disposable. Non-stick pans degrade in two years. Sheet pans warp. Cheap stockpots corrode. A quality Dutch oven operates on a completely different timeline. The right enameled cast iron or bare cast iron pot can serve your family for 50 years or more — and the only maintenance required is occasional re-seasoning for bare iron, or a little Bar Keepers Friend for enamel.</p>
<p>The physics of cast iron cooking never gets old, either. Exceptional heat retention means sears that actually sear. Low, even heat distribution means braises that melt collagen without scorching. A tight-fitting lid traps moisture so your meats come out fork-tender every time.</p>

<h2 id="how-to-choose">How to Choose a BIFL Dutch Oven</h2>
<p><strong>Material:</strong> Enameled cast iron is the most versatile choice — the vitreous enamel coating means you can cook acidic foods without seasoning concerns, and cleanup is much easier. Bare cast iron is less expensive and nearly indestructible if properly seasoned, but requires more maintenance.</p>
<p><strong>Size:</strong> For most families, a 5.5–6 quart Dutch oven is the sweet spot. It handles most recipes and fits comfortably in a standard oven. Go larger (7+ qt) if you regularly cook for crowds or do whole-bird roasting.</p>
<p><strong>Lid fit:</strong> A tight-fitting lid is non-negotiable for braising. Look for lids that seat snugly without wobbling — some premium models feature self-basting lids with interior spikes.</p>

<h2 id="top-pick">Top Pick: Le Creuset Signature Round Dutch Oven</h2>
<p>Le Creuset has been making enameled cast iron since 1925 in France, and the Signature Round Dutch Oven is their flagship product. The enamel formulation is exceptionally resistant to chipping, staining, and cracking. They back every piece with a lifetime warranty.</p>
<ul>
<li><strong>Material:</strong> Enameled cast iron, made in France</li>
<li><strong>Size:</strong> Available 1–13.25 qt; 5.5 qt is the sweet spot</li>
<li><strong>Oven safe:</strong> To 500°F (knob)</li>
<li><strong>Warranty:</strong> Lifetime</li>
<li><strong>Price:</strong> $350–$420 for 5.5 qt</li>
</ul>

<h2 id="runner-up">Runner Up: Staub Cocotte</h2>
<p>Staub is Le Creuset's closest rival, and many professional chefs actually prefer it. The self-basting spike lid is the differentiator — small spikes on the interior of the lid continuously drip condensation back onto your food, keeping everything moist during long braises. The matte black enamel interior hides staining beautifully.</p>

<h2 id="best-value">Best Value: Lodge Enameled Cast Iron</h2>
<p>Lodge has been making cast iron in South Pittsburg, Tennessee since 1896. Their enameled line offers genuine BIFL quality at $60–$120 — a fraction of the French premium brands. Same cast iron quality Lodge is famous for, with a durable porcelain enamel finish. The best buy if you want genuine longevity without the luxury markup.</p>

<h2 id="care">Care & Maintenance</h2>
<p>Hand wash only — dishwashers can dull and degrade enamel over time. Use wooden, silicone, or nylon utensils; metal can scratch enamel interiors. Let it cool before washing to avoid thermal shock. For stubborn stains on light interiors, Bar Keepers Friend works wonders. Store with the lid slightly ajar to allow airflow. Never preheat an empty Dutch oven — always add oil or liquid before applying heat.</p>

<h2 id="verdict">The Verdict</h2>
<p>For most people: if you can spend $350+, get the Le Creuset or Staub. If you want American-made quality at a fair price, Lodge Enameled is genuinely excellent at a third of the cost. Any of these choices, made once, will outlive you. That's the whole point.</p>
    `,
  },
  {
    slug: "best-mechanical-watches-that-last-a-lifetime",
    title: "Best Mechanical Watches That Last a Lifetime",
    excerpt:
      "In an era of disposable electronics, a quality mechanical watch is a radical act. No battery, no planned obsolescence — just precision engineering that lasts generations.",
    category: "edc",
    image: "https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=800&h=500&fit=crop",
    author: "Alex Nakamura",
    date: "2026-04-03",
    readTime: "16 min read",
    featured: false,
    products: [],
    content: `
<h2 id="why-mechanical">Why a Mechanical Watch Is a BIFL Essential</h2>
<p>Mechanical watches predate the quartz revolution by centuries. The finest Swiss and Japanese watchmakers have been refining their movements for over 150 years. The result is a category of tool that's extremely well understood, globally serviceable, and designed with an assumption of indefinite life.</p>
<p>Unlike digital devices, a mechanical watch has no obsolescence built in. The movement inside a Rolex Submariner made in 1970 is still being serviced by watchmakers today. Parts are machined, not manufactured with expiration dates. When something breaks, it can be fixed — often by skilled watchmakers anywhere in the world.</p>

<h2 id="how-to-choose">How to Choose a BIFL Mechanical Watch</h2>
<p><strong>Movement type:</strong> Automatic (self-winding via wrist movement) is best for everyday wear. Manual-wind requires daily winding but offers a more intimate ritual. Both are equally serviceable over time.</p>
<p><strong>Service intervals:</strong> Most mechanical watches need servicing every 5–10 years depending on movement type. Budget $200–$600 for most service-grade watches; more for Rolex/Omega. The Co-Axial escapement in Omega movements requires less lubrication and can go 8–10 years between services.</p>
<p><strong>Case material:</strong> 316L stainless steel is the BIFL standard — corrosion-resistant, scratch-resistant, serviceable for life. Rolex uses 904L, an even more corrosion-resistant alloy.</p>

<h2 id="top-pick">Top Pick: Rolex Submariner</h2>
<p>The Rolex Submariner is the benchmark against which all dive watches are measured. It's been in continuous production since 1953 — which is itself the most powerful endorsement of its longevity. Rolex manufactures their own movements, cases, bracelets, and dials. Every part is designed to be serviced indefinitely.</p>
<ul>
<li><strong>Movement:</strong> Calibre 3235 (in-house, 70-hour power reserve, COSC certified)</li>
<li><strong>Water resistance:</strong> 300m</li>
<li><strong>Case:</strong> 904L stainless steel</li>
<li><strong>Price:</strong> $9,000–$15,000+ new</li>
<li><strong>Value retention:</strong> Exceptional — often appreciates in value</li>
</ul>

<h2 id="runner-up">Runner Up: Omega Seamaster Professional 300M</h2>
<p>The Omega Seamaster is the choice of working divers, military professionals, and James Bond. Omega's Co-Axial escapement means longer service intervals (every 8–10 years), and the METAS-certified movement inside modern models is one of the most accurate and durable available at this price point. At $5,000–$8,000, it's meaningfully less than the Submariner while delivering comparable long-term quality.</p>

<h2 id="best-value">Best Value: Seiko Prospex "Turtle"</h2>
<p>For those who want a genuinely BIFL mechanical watch without the luxury price tag, Seiko's Prospex line is the answer. The 6R35 calibre is an in-house movement with a 70-hour power reserve and a proven track record for decades of reliability. At $400–$800, it's the best dollar-per-lifetime value in mechanical watches.</p>

<h2 id="budget-pick">Budget Pick: Orient Bambino</h2>
<p>The Orient Bambino is the most surprising value on this list. Under $200 for an in-house automatic movement, sapphire crystal, and a classic design that ages beautifully. Orient manufactures their own movements in Japan — meaning parts availability is controlled and long-term serviceability is assured. The best entry point into BIFL watchmaking.</p>

<h2 id="care">Care & Maintenance</h2>
<p>Have water resistance tested annually if you swim with the watch — gaskets degrade over time. Keep away from strong magnetic fields (phone chargers, speakers). Always screw down the crown on water-resistant models before water exposure. Store in a watch box or pouch. For service, use a watchmaker certified by the watch's manufacturer for best results.</p>

<h2 id="verdict">The Verdict</h2>
<p>Any mechanical watch, properly serviced, will outlive its owner. Maximum heirloom value: Rolex Submariner. Best value Swiss manufacture: Omega Seamaster or Tudor Black Bay. Best accessible BIFL: Seiko Prospex. Best budget entry: Orient Bambino. One of these watches, chosen well and cared for, will become the piece your family argues over — in the best way.</p>
    `,
  },
  {
    slug: "best-woodworking-hand-tools-that-last-forever",
    title: "Best Woodworking Hand Tools That Last Forever",
    excerpt:
      "Quality woodworking hand tools are among the most BIFL-worthy purchases on the planet. A Victorian-era plane still cuts perfectly after a sharpening — these are tools made before planned obsolescence existed.",
    category: "tools",
    image: "https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=800&h=500&fit=crop",
    author: "Marcus Rivera",
    date: "2026-04-03",
    readTime: "15 min read",
    featured: false,
    products: [],
    content: `
<h2 id="why-hand-tools">Why Woodworking Hand Tools Are BIFL Essentials</h2>
<p>Power tools get the glory, but hand tools are the soul of woodworking. They're quieter, more precise for fine work, and — critically — they're entirely serviceable. There are no motors to burn out, no batteries to degrade, no electronics to fail. A chisel is steel and a handle. A hand plane is cast iron, steel, and wood. These materials last essentially forever with proper care.</p>
<p>The best hand tools are built from high-carbon steel that can be sharpened repeatedly without losing the ability to hold an edge. The bodies are cast iron, forged steel, or dense hardwood — materials that don't warp, crack, or corrode with normal use and maintenance. Buy them once, sharpen them for life.</p>

<h2 id="how-to-choose">How to Choose BIFL Woodworking Hand Tools</h2>
<p><strong>Steel quality:</strong> Edge tools live or die by their steel. Look for high-carbon steel (O1, A2, or PM-V11 for plane irons; chrome vanadium for chisels). Higher carbon content equals better edge retention.</p>
<p><strong>Repairability:</strong> The best BIFL tools are fully rebuildable. Can you get replacement blades, handles, or hardware? Stanley/Bailey-pattern plane parts are universally available. Veritas and Lie-Nielsen both offer comprehensive parts programs.</p>
<p><strong>Flatness and precision:</strong> For planes, the quality of machined surfaces matters enormously. A plane sole that isn't flat won't cut flat. Premium makers lap their soles to tight tolerances.</p>

<h2 id="best-plane">Best Bench Plane: Lie-Nielsen No. 4</h2>
<p>Lie-Nielsen Toolworks in Warren, Maine makes what many consider the finest production hand planes in the world. The No. 4 Smooth Plane is the most versatile bench plane — ideal for smoothing surfaces and taking gossamer shavings that make sandpaper unnecessary.</p>
<ul>
<li><strong>Body:</strong> Ductile iron casting, machined to tight tolerances</li>
<li><strong>Blade:</strong> A2 tool steel with exceptional edge retention</li>
<li><strong>Handles:</strong> Cherry wood</li>
<li><strong>Made in:</strong> Warren, Maine</li>
<li><strong>Price:</strong> $325–$425</li>
</ul>

<h2 id="best-chisels">Best Chisels: Two Cherries Socket Chisels</h2>
<p>German-made Two Cherries chisels have been made in Remscheid, Germany's toolmaking heartland since 1856. Chrome vanadium high-carbon steel with excellent edge retention. The socket construction (as opposed to tang) allows handle replacement if it ever splits — the chisel body itself lasts forever. At $180–$280 for a 6-piece set, these are the last chisels you'll ever need.</p>
<p>For a more accessible option, Czech-made Narex Premium chisels deliver exceptional quality at $80–$150 for a full set. Hardened to 59 HRC, with hornbeam handles that resist splitting. These are genuinely excellent chisels that outperform anything in a big-box store.</p>

<h2 id="best-saw">Best Hand Saw: Gyokucho Razorsaw</h2>
<p>Japanese pull saws are a different paradigm from Western push saws, and the Gyokucho Razorsaw is the BIFL standard in this category. The impulse-hardened teeth cut dramatically faster and cleaner than most Western saws. The key BIFL feature: replacement blades are available and inexpensive, meaning the handle is a permanent investment and only the blade consumable ever needs replacing. At $25–$60 for the saw and $12–$20 for replacement blades, it's unbeatable value.</p>

<h2 id="layout-tool">Best Layout Tool: Veritas Wheel Marking Gauge</h2>
<p>Layout work is only as accurate as your tools. The Veritas Wheel Marking Gauge features a carbide wheel cutter that is essentially permanent — it won't dull. Solid brass construction won't corrode or degrade. At $65–$80, it replaces all disposable marking tools permanently and permanently.</p>

<h2 id="care">Care & Maintenance</h2>
<p><strong>Sharpening is everything.</strong> A sharp tool is safe and pleasurable to use. Learn to sharpen using waterstones (1000 → 4000 → 8000 grit) or diamond plates, and finish on a loaded leather strop. A honing guide ensures consistent bevel angles for beginners.</p>
<p>Store chisels in a roll or box where blades can't contact each other. Wipe metal surfaces with camellia oil or paste wax after use. Hand planes should be stored on their sides with the blade retracted. Apply paste wax to plane soles — it prevents rust and reduces friction. Wooden handles benefit from occasional linseed oil to prevent cracking.</p>

<h2 id="verdict">Start Here, Build Over Time</h2>
<p>You don't need to buy everything at once. Start with a quality bench plane (Lie-Nielsen or Veritas), a set of Narex chisels, and a Gyokucho Razorsaw — under $400 total for a lifetime of capable hand tool work. Add the Veritas Marking Gauge and specialized planes as your skills and projects demand. Quality hand tools don't depreciate — they appreciate. Buy them once, care for them, pass them down.</p>
    `,
  },
];

// Helper functions
export function getArticleBySlug(slug: string): Article | undefined {
  return articles.find((a) => a.slug === slug);
}

export function getProductBySlug(slug: string): Product | undefined {
  return products.find((p) => p.slug === slug);
}

export function getArticlesByCategory(categorySlug: string): Article[] {
  return articles.filter((a) => a.category === categorySlug);
}

export function getProductsByCategory(categorySlug: string): Product[] {
  return products.filter((p) => p.category === categorySlug);
}

export function getCategoryBySlug(slug: string): Category | undefined {
  return categories.find((c) => c.slug === slug);
}

export function getFeaturedArticles(): Article[] {
  return articles.filter((a) => a.featured);
}

export function getRelatedArticles(
  currentSlug: string,
  category: string,
  limit = 3
): Article[] {
  return articles
    .filter((a) => a.slug !== currentSlug && a.category === category)
    .slice(0, limit);
}

export function formatDate(dateStr: string): string {
  return new Date(dateStr).toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });
}
