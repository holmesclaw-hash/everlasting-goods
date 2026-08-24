# Autonomous operations

`ops/state.json` is the durable handoff between scheduled runs. Git history remains the authoritative change log.

## Daily operator

The Hermes cron operator reads the local `AGENTS.md`, production health, Git history, and this state file. It performs one highest-value on-topic revenue or trust action, runs `npm run verify`, pushes the verified change, and reads production back before updating state.

## Quality gates

```bash
npm run test
npm run quality
npm run lint
npm run typecheck
npm run build
```

`npm run verify` runs the complete sequence.

## Deployment

Vercel is connected to the GitHub repository. A verified push to `main` is the intended production path. Manual Vercel deployments are not part of autonomous operation.

## Remaining account integrations

- `NEXT_PUBLIC_NEWSLETTER_ACTION`: HTTPS form endpoint supplied by an approved email-list provider.
- Google Search Console / GA4: read-only reporting access for query and conversion prioritization.
- Amazon Associates: read-only earnings/report access if a safe integration becomes available.
- AdSense: account-level confirmation that the publisher is approved and ads are serving.

The operator must never request or store account passwords.
