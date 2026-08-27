export interface ArticleImageEvidence {
  image: string;
  exact_product_model: string;
  source_url: string;
  rights_basis: "owned-original" | "manufacturer-editorial" | "affiliate-api" | "open-license";
  license: string;
  license_url: string;
  attribution: string;
  alt: string;
}

export const articleImageEvidence: Record<string, ArticleImageEvidence>;
