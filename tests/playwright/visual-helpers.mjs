import { expect } from "@playwright/test";
import { execFileSync } from "node:child_process";
import fs from "node:fs/promises";
import { assertVisualState } from "./visual-state-helpers.mjs";

export * from "./visual-state-helpers.mjs";

let sourceMetadataCache = null;

function readGitValue(args, fallback) {
  try {
    return execFileSync("git", args, { encoding: "utf8" }).trim();
  } catch {
    return fallback;
  }
}

function sourceMetadata() {
  if (sourceMetadataCache !== null) {
    return sourceMetadataCache;
  }

  const dirtyStatus = readGitValue(["status", "--short"], "");
  sourceMetadataCache = {
    revision: process.env.OCEANGAME_SOURCE_REVISION ?? readGitValue(["rev-parse", "--short=12", "HEAD"], "unknown"),
    branch: process.env.OCEANGAME_SOURCE_BRANCH ?? readGitValue(["branch", "--show-current"], "unknown"),
    dirty: dirtyStatus.length > 0,
  };
  return sourceMetadataCache;
}

export async function bootGame(page) {
  await page.goto("/");
  const canvas = page.locator("canvas").first();
  await expect(canvas).toBeVisible({ timeout: 60_000 });
  await page.waitForTimeout(2_000);

  const viewport = page.viewportSize() ?? { width: 1280, height: 720 };
  await canvas.click({
    position: {
      x: Math.floor(viewport.width / 2),
      y: Math.floor(viewport.height / 2),
    },
  });
  await page.keyboard.press("F9");
  await page.waitForTimeout(600);
  return canvas;
}

export async function holdKey(page, key, durationMs) {
  await page.keyboard.down(key);
  await page.waitForTimeout(durationMs);
  await page.keyboard.up(key);
}

export async function holdKeys(page, keys, durationMs) {
  for (const key of keys) {
    await page.keyboard.down(key);
  }
  await page.waitForTimeout(durationMs);
  for (const key of keys.reverse()) {
    await page.keyboard.up(key);
  }
}

export async function capture(page, testInfo, name, expectedState = {}, evidence = {}) {
  await assertVisualState(page, expectedState);
  const visualState = await page.evaluate(() => window.__oceangameVisualState ?? {});
  const path = testInfo.outputPath(`${name}.png`);
  const metadataPath = testInfo.outputPath(`${name}.json`);
  const capturedAt = new Date().toISOString();
  const viewport = page.viewportSize();
  await page.screenshot({ path });
  await fs.writeFile(
    metadataPath,
    `${JSON.stringify(
      {
        capture: name,
        capturedAt,
        source: sourceMetadata(),
        expectedState,
        visualState,
        viewport,
        evidence,
      },
      null,
      2,
    )}\n`,
  );
  testInfo.attachments.push({ name, path, contentType: "image/png" });
  testInfo.attachments.push({ name: `${name}-metadata`, path: metadataPath, contentType: "application/json" });
  return {
    capture: name,
    capturedAt,
    expectedState,
    visualState,
    viewport,
    screenshot: path,
    metadata: metadataPath,
    evidence,
  };
}
