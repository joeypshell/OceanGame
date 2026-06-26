import { existsSync, mkdirSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(dirname(fileURLToPath(import.meta.url)), "../..");
const outputPath = resolve(repoRoot, process.env.OCEANGAME_WEB_EXPORT ?? "exports/web/index.html");
const outputDir = dirname(outputPath);

function resolveGodotBinary() {
  if (process.env.GODOT_BIN) {
    return process.env.GODOT_BIN;
  }

  if (process.platform === "win32") {
    const candidates = [
      "C:/Program Files/Godot/Godot_v4.7-stable_windows_arm64_console.exe",
      "C:/Program Files/Godot/Godot_v4.7-stable_windows_x86_64_console.exe",
      "C:/Program Files/Godot/Godot_v4.7-stable_windows_arm64.exe",
      "C:/Program Files/Godot/Godot_v4.7-stable_windows_x86_64.exe"
    ];
    const found = candidates.find((candidate) => existsSync(candidate));
    if (found) {
      return found;
    }
  }

  return "godot";
}

mkdirSync(outputDir, { recursive: true });

const godot = resolveGodotBinary();
const result = spawnSync(
  godot,
  ["--headless", "--path", repoRoot, "--export-release", "Web", outputPath],
  {
    cwd: repoRoot,
    encoding: "utf8",
    stdio: "inherit"
  }
);

if (result.error) {
  console.error(`Failed to launch Godot export binary: ${result.error.message}`);
  process.exit(1);
}

if (result.status !== 0) {
  console.error(`Godot web export failed with exit code ${result.status}.`);
  process.exit(result.status ?? 1);
}

if (!existsSync(outputPath)) {
  console.error(`Godot web export did not create ${outputPath}.`);
  process.exit(1);
}

console.log(`Godot web export ready: ${outputPath}`);
