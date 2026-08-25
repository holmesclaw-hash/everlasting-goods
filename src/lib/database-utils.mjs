export function groupProductsByCategory(products) {
  return [...products]
    .sort((a, b) => a.category.localeCompare(b.category) || a.brand.localeCompare(b.brand) || a.model.localeCompare(b.model))
    .reduce((groups, product) => {
      (groups[product.category] ??= []).push(product);
      return groups;
    }, {});
}

export function calculateCostPerYear({ price, serviceLifeYears, annualMaintenance = 0 }) {
  if (price == null || serviceLifeYears == null || serviceLifeYears <= 0) return null;
  return Math.round((price / serviceLifeYears + (annualMaintenance ?? 0)) * 100) / 100;
}

export function repairOrReplaceDecision({ repairQuote, replacementPrice, expectedServiceLifeYears }) {
  if (replacementPrice == null || expectedServiceLifeYears == null || expectedServiceLifeYears <= 0) {
    return {
      status: "insufficient-evidence",
      message: "Replacement economics are not yet verified for this product.",
    };
  }

  return {
    status: "comparison",
    repairShareOfReplacement: Math.round((repairQuote / replacementPrice) * 1000) / 1000,
    replacementCostPerYear: calculateCostPerYear({ price: replacementPrice, serviceLifeYears: expectedServiceLifeYears }),
  };
}

export function evidenceLabel(tier) {
  return {
    T1: "T1 — First-party",
    T2: "T2 — Manufacturer documentation",
    T3: "T3 — Corroborated owner reports",
    T4: "T4 — Not yet verified",
  }[tier] ?? "Evidence tier unavailable";
}
