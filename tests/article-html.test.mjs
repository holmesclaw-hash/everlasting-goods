import assert from "node:assert/strict";
import test from "node:test";

import { renderArticleHtml } from "../src/lib/article-html.mjs";

test("removes executable and embedded content from generated article HTML", () => {
  const input = `<p onclick="steal()">Safe text</p><script>alert(1)</script><iframe src="https://example.com"></iframe>`;
  const output = renderArticleHtml(input);

  assert.match(output, /<p>Safe text<\/p>/);
  assert.doesNotMatch(output, /onclick|script|iframe|alert\(1\)/i);
});

test("removes unsafe URL schemes while keeping ordinary article markup", () => {
  const input = `<h2 id="pick">Pick</h2><p><a href="javascript:alert(1)" target="_blank">Bad</a> <a href="/about">About</a></p>`;
  const output = renderArticleHtml(input);

  assert.match(output, /<h2 id="pick">Pick<\/h2>/);
  assert.doesNotMatch(output, /javascript:/i);
  assert.match(output, /href="\/about"/);
});

test("normalizes and qualifies Amazon links after sanitizing", () => {
  const input = `<p><a href="https://www.amazon.com/dp/B00006JSUA?tag=everlastin09f-20" rel="nofollow">Product</a></p>`;
  const output = renderArticleHtml(input);

  assert.match(output, /\/dp\/B00006JSUA\?tag=everlastin08f-20/);
  assert.match(output, /rel="sponsored nofollow noopener noreferrer"/);
});
