import assert from "node:assert/strict";
import test from "node:test";

import {
  EDITORIAL_AUTHOR,
  articleAuthorJsonLd,
  publicArticleAuthor,
} from "../src/lib/editorial.mjs";

test("publishes research articles under the real editorial identity", () => {
  assert.equal(EDITORIAL_AUTHOR, "Everlasting Goods Editorial Team");
  assert.equal(publicArticleAuthor("James Chen"), EDITORIAL_AUTHOR);
  assert.equal(publicArticleAuthor("Elena Torres"), EDITORIAL_AUTHOR);
});

test("describes the editorial author as an organization in structured data", () => {
  assert.deepEqual(articleAuthorJsonLd(), {
    "@type": "Organization",
    name: EDITORIAL_AUTHOR,
    url: "https://everlasting-goods.com/about",
  });
});
