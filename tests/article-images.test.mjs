import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

import { articleImageEvidence } from "../src/content/article-image-evidence.mjs";

const dataSource = await readFile(new URL("../src/lib/data.ts", import.meta.url), "utf8");
const articlesSource = dataSource.slice(
  dataSource.indexOf("export const articles: Article[] = ["),
  dataSource.indexOf("// Helper functions"),
);

const articleImages = Array.from(
  articlesSource.matchAll(/slug:\s*"([^"]+)"[\s\S]*?image:\s*"([^"]+)"/g),
  ([, slug, image]) => ({ slug, image }),
);

test("every article has a parsed hero image", () => {
  assert.equal(articleImages.length, 54);
  for (const { slug, image } of articleImages) {
    if (image.startsWith("/images/articles/")) {
      assert.equal(articleImageEvidence[slug]?.image, image, `${slug} local image needs provenance`);
    } else {
      assert.match(image, /^https:\/\//, `${slug} must use an absolute HTTPS or documented local image`);
    }
  }
});

test("an article hero is not reused as a broad fallback", () => {
  const slugsByImage = new Map();
  for (const { slug, image } of articleImages) {
    slugsByImage.set(image, [...(slugsByImage.get(image) ?? []), slug]);
  }

  const broadFallbacks = Array.from(slugsByImage, ([image, slugs]) => ({ image, slugs }))
    .filter(({ slugs }) => slugs.length > 2);

  assert.deepEqual(
    broadFallbacks,
    [],
    `Hero images reused across unrelated articles: ${JSON.stringify(broadFallbacks)}`,
  );
});
