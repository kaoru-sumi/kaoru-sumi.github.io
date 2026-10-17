const path = require("path");
const { devices } = require("@playwright/test");

const repoRoot = path.resolve(__dirname, "../..");
const baseURL = process.env.SITE_URL || "http://127.0.0.1:4000";

module.exports = {
  testDir: __dirname,
  testMatch: "site.spec.js",
  outputDir: path.join(repoRoot, "test-results"),
  fullyParallel: true,
  forbidOnly: Boolean(process.env.CI),
  retries: process.env.CI ? 1 : 0,
  workers: process.env.CI ? 2 : undefined,
  timeout: 60000,
  expect: { timeout: 10000 },
  reporter: [["list"], ["html", { outputFolder: path.join(repoRoot, "output/playwright"), open: "never" }]],
  use: {
    baseURL,
    browserName: "chromium",
    colorScheme: "light",
    reducedMotion: "reduce",
    screenshot: "only-on-failure",
    trace: "retain-on-failure",
  },
  webServer: process.env.NO_WEBSERVER
    ? undefined
    : {
        // Exercise the real site at its configured root, never the demo overlay.
        command: "bundle exec jekyll serve --host 127.0.0.1 --port 4000 --no-watch --quiet",
        cwd: repoRoot,
        env: { JEKYLL_ENV: "production" },
        url: baseURL,
        reuseExistingServer: false,
        timeout: 300000,
        stdout: "pipe",
        stderr: "pipe",
      },
  projects: [
    { name: "desktop", use: { viewport: { width: 1366, height: 900 } } },
    // A Chromium touch viewport keeps the CI dependency small; this is not Safari coverage.
    { name: "mobile", use: { ...devices["Pixel 7"] } },
  ],
};
