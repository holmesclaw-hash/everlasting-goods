export const EDITORIAL_AUTHOR: string;
export function publicArticleAuthor(legacyAuthor?: string): string;
export function articleAuthorJsonLd(): {
  "@type": "Organization";
  name: string;
  url: string;
};
