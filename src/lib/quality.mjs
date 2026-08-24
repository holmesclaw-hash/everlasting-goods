const RULES = [
  [/everlastin09f-20/i, "stale Amazon Associates tag"],
  [
    /\b(?:we tested|after testing|we['’]ve seen|i['’]ve (?:had|been|seen|personally)|i have (?:used|owned|tested)|my (?:pair|hiking buddy|holy grail))\b/i,
    "unsupported hands-on testing claim",
  ],
  [/10,000\+ readers/i, "unsupported audience-size claim"],
  [/plausible human name/i, "fabricated author instruction"],
  [/BIFL\s*(?:\(|means\s+)(?:Big In France|Battery Indicators For Life)/i, "corrupted BIFL definition"],
  [/preventDefault\(\)/, "nonfunctional newsletter form"],
  [/hands-on with every product/i, "unsupported universal testing claim"],
  [/\bproduct\.price\b/, "unverified product price display"],
  [/\bproduct\.rating\b/, "unverified product rating display"],
  [/["']@type["']\s*:\s*["']ProductReview["']/, "invalid ProductReview schema type"],
  [/\bexpert (?:guide|review|pick)/i, "unsupported expertise claim"],
  [/(?:\bevery product\b[^\n]*\btested\b|\btested,\s*vetted\b)/i, "unsupported universal testing claim"],
];

export function findEditorialQualityIssues(text) {
  const issues = [];
  for (const line of text.split(/\r?\n/)) {
    for (const [pattern, message] of RULES) {
      if (pattern.test(line)) issues.push(message);
    }
  }
  return issues;
}
