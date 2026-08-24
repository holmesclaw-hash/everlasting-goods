export const EDITORIAL_AUTHOR = "Everlasting Goods Editorial Team";

export function publicArticleAuthor(_legacyAuthor) {
  void _legacyAuthor;
  return EDITORIAL_AUTHOR;
}

export function articleAuthorJsonLd() {
  return {
    "@type": "Organization",
    name: EDITORIAL_AUTHOR,
    url: "https://everlasting-goods.com/about",
  };
}
