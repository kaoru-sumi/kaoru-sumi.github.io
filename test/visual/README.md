# Research-site browser checks

`npm run test:visual` now checks the production research site at `/`, using `_config.yml` without demo fixtures or an upstream Git tag. Install dependencies with `npm ci` and `npx playwright install chromium` first; Ruby/Bundler dependencies must also be installed.

The suite covers English and Japanese core pages in light/dark mode at desktop and mobile Chromium viewports. It checks successful documents and local assets, responsive layout, basic accessibility semantics, repeated keyboard navigation, bilingual round trips, and the CV download. Every page render is attached to the HTML report at `output/playwright/index.html`; failures also include screenshots and traces in `test-results/`.

These are smoke/render checks, **not pixel-diff regression tests**, a complete accessibility audit, or Safari coverage. Screenshots are review artifacts; no unrelated upstream screenshot is treated as this site's approved design.

To test an already-running local production build (for example after CSS purging):

```bash
NO_WEBSERVER=1 SITE_URL=http://127.0.0.1:4000 npm run test:visual
```

The existing `test:visual:update` command runs the same suite but does not establish screenshot baselines. Reviewed site-specific baselines can be added separately when a design is approved.

## Optional upstream theme diagnostics

The inherited demo/parity specs are preserved, but excluded from the default suite and CI. To investigate a theme migration explicitly:

```bash
npx playwright install chromium webkit
npx playwright test --config test/visual/upstream.playwright.config.js
```

That configuration uses `test/serve_demo_site.sh` to prepare an isolated demo fixture site at `/al-folio`. Some inherited specs require stock demo content and may not match this customized site. Optional parity comparisons also require a separately prepared baseline server and `BASELINE_URL`; no tag is fetched or assumed automatically. Do not use this suite or its demo configuration for deployment or as the research site's approval gate.
