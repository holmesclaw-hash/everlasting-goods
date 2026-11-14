export function groupProductsByCategory(products) {
  return [...products]
    .sort((a, b) => a.category.localeCompare(b.category) || a.brand.localeCompare(b.brand) || a.model.localeCompare(b.model))
    .reduce((groups, product) => {
      (groups[product.category] ??= []).push(product);
      return groups;
    }, {});
}

export function formatDatabaseLabel(value) {
  return value
    .split(/[-_]+/)
    .filter(Boolean)
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(" ");
}

export function selectImageVerifiedProducts(products, limit) {
  return products
    .filter((product) =>
      product.image_url &&
      product.image_source_url &&
      product.image_license_basis &&
      product.image_license_url &&
      product.image_attribution &&
      product.image_alt
    )
    .slice(0, limit);
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

export function formatFieldFreshness(field) {
  if (field.evidence_tier === "T4") {
    if (field.is_stale) {
      return `Evidence gap reviewed ${field.verified_date}; no verified value yet; research review overdue since ${field.stale_after}.`;
    }
    return `Evidence gap reviewed ${field.verified_date}; no verified value yet; research review due ${field.stale_after}.`;
  }

  if (field.is_stale) {
    return `Verified ${field.verified_date}; recheck every ${field.reverify_days} days; stale since ${field.stale_after}.`;
  }
  return `Verified ${field.verified_date}; recheck every ${field.reverify_days} days; stale after ${field.stale_after}.`;
}
