const assert = require("node:assert/strict");
const fs = require("node:fs");
const os = require("node:os");
const path = require("node:path");
const { spawnSync } = require("node:child_process");

const root = path.resolve(__dirname, "..");
const temporary = fs.mkdtempSync(path.join(os.tmpdir(), "site-contract-"));
try {
  for (const file of [
    "package.json",
    "_config.yml",
    "Gemfile",
    "test/style_contract.js",
    "test/integration_plugin_toggles.sh",
    "test/integration_distill.sh",
  ]) {
    const target = path.join(temporary, file);
    fs.mkdirSync(path.dirname(target), { recursive: true });
    fs.copyFileSync(path.join(root, file), target);
  }
  fs.mkdirSync(path.join(temporary, "test/visual"), { recursive: true });
  fs.mkdirSync(path.join(temporary, "_includes/hook"), { recursive: true });
  fs.writeFileSync(path.join(temporary, "_includes/hook/bib.liquid"), "reviewed override");
  fs.writeFileSync(path.join(temporary, "_includes/selected_papers.liquid"), "reviewed override");
  const check = () => spawnSync(process.execPath, ["test/style_contract.js"], { cwd: temporary, encoding: "utf8" });
  assert.equal(check().status, 0, "Reviewed site overrides must be allowed");
  const unreviewed = path.join(temporary, "_includes/header.liquid");
  fs.writeFileSync(unreviewed, "unreviewed override");
  const unexpected = check();
  assert.equal(unexpected.status, 1, "An unreviewed override must fail");
  assert.match(unexpected.stderr, /Unreviewed site override.*header\.liquid/);
  fs.unlinkSync(unreviewed);
  fs.mkdirSync(path.join(temporary, "_sass"));
  assert.equal(check().status, 1, "Other runtime directories must still fail");
  fs.rmdirSync(path.join(temporary, "_sass"));
  const config = path.join(temporary, "_config.yml");
  fs.writeFileSync(config, fs.readFileSync(config, "utf8").replace("theme: al_folio_core", "theme: invalid"));
  assert.equal(check().status, 1, "Broken theme wiring must still fail");
  console.log("Site contract regression tests passed (allowed override and three negative controls).");
} finally {
  fs.rmSync(temporary, { recursive: true, force: true });
}
