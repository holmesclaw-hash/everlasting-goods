import sanitizeHtml from "sanitize-html";

import { normalizeArticleAffiliateLinks } from "./affiliate.mjs";

const ALLOWED_TAGS = [
  "p",
  "h2",
  "h3",
  "h4",
  "ul",
  "ol",
  "li",
  "a",
  "strong",
  "em",
  "b",
  "i",
  "blockquote",
  "div",
  "span",
  "table",
  "thead",
  "tbody",
  "tr",
  "th",
  "td",
  "br",
  "hr",
];

const ALLOWED_ATTRIBUTES = {
  a: ["href", "target", "rel", "class"],
  h2: ["id", "class"],
  h3: ["id", "class"],
  h4: ["id", "class"],
  div: ["class"],
  span: ["class"],
  table: ["class"],
  thead: ["class"],
  tbody: ["class"],
  tr: ["class"],
  th: ["class", "scope"],
  td: ["class"],
};

export function renderArticleHtml(content) {
  const sanitized = sanitizeHtml(content, {
    allowedTags: ALLOWED_TAGS,
    allowedAttributes: ALLOWED_ATTRIBUTES,
    allowedSchemes: ["http", "https", "mailto"],
    allowProtocolRelative: false,
    disallowedTagsMode: "discard",
    enforceHtmlBoundary: true,
  });

  return normalizeArticleAffiliateLinks(sanitized);
}
