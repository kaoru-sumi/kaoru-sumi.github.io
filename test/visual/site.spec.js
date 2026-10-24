const fs = require("node:fs/promises");
const path = require("node:path");
const { test, expect } = require("@playwright/test");

const routes = [
  { path: "/", heading: /Kaoru\s+Sumi/, lang: "en" },
  { path: "/research/", heading: "Research", lang: "en" },
  { path: "/publications/", heading: "Publications", lang: "en" },
  { path: "/lab/", heading: "PAHAI Lab", lang: "en" },
  { path: "/awards/", heading: "Awards", lang: "en" },
  { path: "/contact/", heading: "Contact", lang: "en" },
  { path: "/ja/", heading: "角 薫", lang: "ja" },
  { path: "/ja/research/", heading: "研究", lang: "ja" },
  { path: "/ja/lab/", heading: "PAHAI研究室", lang: "ja" },
  { path: "/ja/awards/", heading: "受賞", lang: "ja" },
  { path: "/ja/contact/", heading: "お問合せ", lang: "ja" },
];

const reviewScreenshots = {
  desktop: { "/": "01-desktop-home-english.png", "/ja/": "02-desktop-home-japanese.png", "/publications/": "03-desktop-publications.png" },
  mobile: { "/": "04-mobile-home-english.png" },
};

async function preparePage(page, theme = "light") {
  await page.addInitScript((value) => localStorage.setItem("theme", value), theme);
  // Optional embeds must not make a local site check depend on analytics or Maps.
  // Essential scripts, fonts, stylesheets, and all site-owned assets still load normally.
  await page.route(/https:\/\/([^/]+\.)?(google-analytics\.com|plausible\.io|badge\.dimensions\.ai|d1bxh8uas1mnw7\.cloudfront\.net)\//, (route) =>
    route.fulfill({ status: 200, contentType: "application/javascript", body: "" })
  );
  await page.route(/https:\/\/www\.google\.com\/maps\?/, (route) =>
    route.fulfill({ status: 200, contentType: "text/html", body: "<!doctype html><title>Map fixture</title>" })
  );
}

async function openPage(page, path) {
  const response = await page.goto(path, { waitUntil: "load" });
  expect(response, `No document response for ${path}`).not.toBeNull();
  expect(response.status(), `Document response for ${path}`).toBe(200);
  await expect(page.getByRole("main")).toBeVisible();
}

for (const theme of ["light", "dark"]) {
  for (const route of routes) {
    test(`${route.path} passes render and accessibility smoke checks (${theme})`, async ({ page, baseURL, isMobile }, testInfo) => {
      const failedAssets = [];
      const siteOrigin = new URL(baseURL).origin;
      page.on("response", (response) => {
        if (new URL(response.url()).origin === siteOrigin && response.status() >= 400) {
          failedAssets.push(`${response.status()} ${response.url()}`);
        }
      });
      page.on("requestfailed", (request) => {
        if (new URL(request.url()).origin === siteOrigin) {
          failedAssets.push(`${request.failure()?.errorText} ${request.url()}`);
        }
      });

      await preparePage(page, theme);
      await openPage(page, route.path);
      const main = page.getByRole("main");
      await expect(page.locator("html")).toHaveAttribute("lang", route.lang);
      await expect(page.locator("html")).toHaveAttribute("data-theme", theme);
      await expect(page).toHaveTitle(/Kaoru Sumi/);
      await expect(page.locator('meta[name="viewport"]')).toHaveAttribute("content", /width=device-width/);
      await expect(main).toHaveCount(1);
      await expect(page.getByRole("heading", { level: 1 })).toHaveCount(1);
      await expect(page.getByRole("heading", { level: 1, name: route.heading, exact: true })).toBeVisible();
      await expect(page.locator("#navbar")).toBeVisible();
      await expect(page.locator('#navbar a[href^="/al-folio/"]')).toHaveCount(0);

      // These are basic accessibility regressions, not a replacement for an axe/manual audit.
      await expect(main.locator("img:not([alt])")).toHaveCount(0);
      await expect(main.locator('iframe:not([title]), iframe[title=""]')).toHaveCount(0);
      // Collapsed mobile-menu controls are intentionally absent from the accessibility tree.
      // Check their names only while the menu is open, then restore the normal page render.
      const navigationToggle = page.getByRole("button", { name: "Toggle navigation", exact: true });
      if (isMobile) {
        await navigationToggle.click();
        await expect(navigationToggle).toHaveAttribute("aria-expanded", "true");
      }
      await expect(page.locator("#search-toggle")).toBeVisible();
      await expect(page.locator("#search-toggle")).toHaveAccessibleName(/search/i);
      await expect(page.locator("#light-toggle")).toBeVisible();
      await expect(page.locator("#light-toggle")).toHaveAccessibleName(/theme/i);
      if (isMobile) {
        await page.keyboard.press("Escape");
        await expect(navigationToggle).toHaveAttribute("aria-expanded", "false");
        await expect(page.locator("#search-toggle")).toBeHidden();
      }

      // Force below-the-fold local images to load before checking and capturing the page.
      await main.locator("img").evaluateAll((images) => images.forEach((image) => (image.loading = "eager")));
      await expect
        .poll(() =>
          main.locator("img").evaluateAll((images) =>
            images
              .filter((image) => new URL(image.currentSrc || image.src, location.href).origin === location.origin)
              .filter((image) => !image.complete || image.naturalWidth === 0)
              .map((image) => image.getAttribute("src"))
          )
        )
        .toEqual([]);
      await page.evaluate(() => document.fonts.ready);

      // Detect missing CSS, collapsed content, and mobile horizontal overflow.
      const layout = await main.evaluate((element) => ({
        contentWidth: element.getBoundingClientRect().width,
        viewportWidth: document.documentElement.clientWidth,
        pageWidth: Math.max(document.documentElement.scrollWidth, document.body.scrollWidth),
        headingSize: parseFloat(getComputedStyle(document.querySelector("h1")).fontSize),
        themeBackground: getComputedStyle(document.documentElement).getPropertyValue("--global-bg-color").trim(),
      }));
      expect(layout.contentWidth).toBeGreaterThan(250);
      expect(layout.contentWidth).toBeLessThanOrEqual(layout.viewportWidth + 1);
      expect(layout.pageWidth, `Horizontal overflow on ${route.path}`).toBeLessThanOrEqual(layout.viewportWidth + 1);
      expect(layout.headingSize).toBeGreaterThan(24);
      expect(layout.themeBackground).not.toBe("");
      expect(failedAssets, "Broken site-owned resources").toEqual([]);

      // Review artifacts, not an automatic comparison with an unrelated upstream demo.
      const screenshot = await page.screenshot({ fullPage: true, animations: "disabled" });
      await testInfo.attach("rendered-page", { body: screenshot, contentType: "image/png" });
      // Keep the user-facing review set small and separate from traces and the full HTML report.
      const reviewName = theme === "light" && reviewScreenshots[testInfo.project.name]?.[route.path];
      if (reviewName) {
        const reviewDirectory = path.resolve(__dirname, "output/review");
        await fs.mkdir(reviewDirectory, { recursive: true });
        await fs.writeFile(path.join(reviewDirectory, reviewName), screenshot);
      }
    });
  }
}

test("English and Japanese navigation makes a round trip", async ({ page }) => {
  await preparePage(page);
  await openPage(page, "/");
  await page.getByRole("main").getByRole("link", { name: "日本語 / Japanese" }).click();
  await expect(page).toHaveURL(/\/ja\/$/);
  await expect(page.locator("html")).toHaveAttribute("lang", "ja");
  const japaneseNavigation = page.getByRole("navigation", { name: "日本語ページ" });
  await japaneseNavigation.locator('a[href="/ja/research/"]').click();
  await expect(page).toHaveURL(/\/ja\/research\/$/);
  await expect(japaneseNavigation.locator('[aria-current="page"]')).toHaveAttribute("href", "/ja/research/");
  await page.getByRole("main").getByRole("link", { name: "English", exact: true }).click();
  await expect(page).toHaveURL(/\/research\/$/);
  await expect(page.locator("html")).toHaveAttribute("lang", "en");
  await page.goBack();
  await expect(page).toHaveURL(/\/ja\/research\/$/);
  await expect(page.locator("html")).toHaveAttribute("lang", "ja");
});

test("primary navigation remains keyboard usable after repeated open and close", async ({ page, isMobile }) => {
  await preparePage(page);
  await openPage(page, "/");
  const navigation = page.locator("#navbar");
  const toggle = navigation.getByRole("button", { name: "Toggle navigation" });
  if (isMobile) {
    await expect(toggle).toBeVisible();
    for (let attempt = 0; attempt < 2; attempt += 1) {
      await toggle.focus();
      await page.keyboard.press("Enter");
      await expect(toggle).toHaveAttribute("aria-expanded", "true");
      await expect(navigation.getByRole("link", { name: "Research", exact: true })).toBeVisible();
      await page.keyboard.press("Escape");
      await expect(toggle).toHaveAttribute("aria-expanded", "false");
      await expect(navigation.getByRole("link", { name: "Research", exact: true })).toBeHidden();
    }
    await toggle.press("Space");
    await expect(toggle).toHaveAttribute("aria-expanded", "true");
  }
  const research = navigation.getByRole("link", { name: "Research", exact: true });
  await research.focus();
  await expect(research).toBeFocused();
  await page.keyboard.press("Enter");
  await expect(page).toHaveURL(/\/research\/$/);
  await expect(page.getByRole("heading", { name: "Research", exact: true, level: 1 })).toBeVisible();
});

test("homepage CV download is a real PDF", async ({ page, request }) => {
  await preparePage(page);
  await openPage(page, "/");
  const cv = page.getByRole("link", { name: "Curriculum Vitae (PDF)", exact: true });
  await expect(cv).toBeVisible();
  const response = await request.get(await cv.getAttribute("href"));
  expect(response.status()).toBe(200);
  expect((await response.body()).subarray(0, 5).toString()).toBe("%PDF-");
});
