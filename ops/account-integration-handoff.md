# Account integration handoff

Reviewed: 2026-08-25

The public application is ready to consume these integrations without storing account passwords. The remaining steps require the account owner to grant access or accept a provider agreement.

## Google Search Console

Current site state:

- The root layout publishes the existing Google site-verification meta token.
- The sitemap is live at `https://everlasting-goods.com/sitemap.xml`.

Owner action:

1. Open the `everlasting-goods.com` property in Search Console.
2. Go to **Settings → Users and permissions → Add user**.
3. Add the Google Account that will run operator reporting.
4. Choose **Restricted** permission for view-only access.

Google documents Restricted users as having simple view rights on most data:
https://support.google.com/webmasters/answer/7687615

After access is granted, record only the property identifier in operator configuration. Do not commit OAuth tokens or account cookies.

## Google Analytics 4

Current site state:

- Consent-gated Google tag ID: `GT-MR86JNFG`.
- Analytics loads only after explicit optional-cookie acceptance.
- The site emits `affiliate_click` and `referral_visit` events.

Owner action:

1. Open the GA4 property associated with `GT-MR86JNFG`.
2. Go to **Admin → Property Access Management → Add users**.
3. Add the Google Account used for operator reporting.
4. Assign **Viewer** at the property level; do not grant Editor or Administrator.

Google documents Viewer as able to see settings and data through the UI or APIs:
https://support.google.com/analytics/answer/9305587

After access is granted, record the GA4 property ID (not a secret). Keep OAuth tokens outside Git.

## Amazon Associates reporting

Current site state:

- Approved tracking tag in code: `everlastin08f-20`.
- Affiliate clicks are tracked only after consent.
- No earnings/report account access is currently available to the operator.

Owner action:

1. In Associates Central, open **Account Settings → Manage Account Users → Add Users**.
2. Invite the account used for operator reporting.
3. Assign **Reports Access**, not Full Access.
4. Accept the invitation before Amazon's invitation window expires.

Amazon documents Reports Access as able to view reports without access to payee information, payment methods, or user management:
https://affiliate-program.amazon.com/help/node/topic/GQPBMBNDZ7DC9DUX

Amazon's user-management instructions:
https://affiliate-program.amazon.com/help/node/topic/GYE3WNKLBUR3GFZQ

The operator can calculate overall earnings per click as:

`commission income / consented affiliate_click events`

This is overall EPC for the shared tracking tag. Page-level Amazon revenue attribution requires approved page-specific tracking IDs or another Amazon-supported attribution mechanism; do not invent it from order totals.

## Newsletter provider

Recommended zero-spend starting provider: **Buttondown**.

Why it fits:

- Provides a standard HTTPS form action compatible with `NEXT_PUBLIC_NEWSLETTER_ACTION`.
- Requires no API key in the browser for the embedded form path.
- The provider's Embedding settings expose the exact form action URL.

Official embedding documentation:
https://docs.buttondown.com/webflow

Owner action:

1. Create or select the Buttondown newsletter and review its current terms and pricing.
2. Open **Settings → Embedding → Form**.
3. Copy the HTTPS form action URL.
4. Add it in the custom-domain Vercel project as `NEXT_PUBLIC_NEWSLETTER_ACTION` for Production.
5. Redeploy and submit a controlled test address.
6. Confirm the subscriber appears in Buttondown and receives the expected confirmation flow.

Do not send the endpoint through public chat if it contains a private token. It can be entered directly into Vercel by the owner.

## AdSense

Current site state:

- `ads.txt` publishes `pub-6903539486133095`.
- Ad scripts remain gated by both explicit consent and `NEXT_PUBLIC_ADSENSE_ENABLED=true`.
- Keep the environment flag unset or false until account approval and meaningful traffic are confirmed.

No autonomous action may enable advertising or change payout/tax settings without owner confirmation.
