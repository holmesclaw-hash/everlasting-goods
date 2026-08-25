import assert from "node:assert/strict";
import test from "node:test";

import nextConfig from "../next.config.mjs";

test("permanently redirects legacy routes to their closest verified replacements", async () => {
  assert.equal(typeof nextConfig.redirects, "function");

  const redirects = await nextConfig.redirects();
  assert.deepEqual(
    redirects.filter(({ source }) => [
      "/cost-per-year",
      "/repair-or-replace",
      "/articles/best-bifl-tool-sets-for-home-repair",
    ].includes(source)),
    [
      {
        source: "/cost-per-year",
        destination: "/tools/cost-per-year",
        permanent: true,
      },
      {
        source: "/repair-or-replace",
        destination: "/tools/repair-or-replace",
        permanent: true,
      },
      {
        source: "/articles/best-bifl-tool-sets-for-home-repair",
        destination: "/database",
        permanent: true,
      },
    ]
  );
});
