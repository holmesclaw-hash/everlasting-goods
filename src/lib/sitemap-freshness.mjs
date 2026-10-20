export function latestReviewDate(products) {
  let latest = null;
  for (const product of products) {
    const reviewed = product?.last_reviewed_date;
    if (typeof reviewed !== "string") continue;
    if (latest === null || reviewed > latest) latest = reviewed;
  }
  return latest;
}

export function latestCategoryReviewDate(products, category) {
  return latestReviewDate(products.filter((product) => product.category === category));
}
