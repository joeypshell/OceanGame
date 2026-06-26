import { createReadStream, existsSync, statSync } from "node:fs";
import { createServer } from "node:http";
import { extname, join, normalize, resolve, sep } from "node:path";
import { fileURLToPath } from "node:url";

const repoRoot = resolve(fileURLToPath(new URL("../..", import.meta.url)));
const webRoot = resolve(repoRoot, process.env.OCEANGAME_WEB_ROOT ?? "exports/web");
const port = Number(process.env.OCEANGAME_WEB_PORT ?? 8060);
const host = process.env.OCEANGAME_WEB_HOST ?? "127.0.0.1";

const contentTypes = {
  ".html": "text/html; charset=utf-8",
  ".js": "text/javascript; charset=utf-8",
  ".wasm": "application/wasm",
  ".pck": "application/octet-stream",
  ".png": "image/png",
  ".svg": "image/svg+xml",
  ".ico": "image/x-icon",
  ".json": "application/json; charset=utf-8"
};

function sendResponse(response, statusCode, body) {
  response.writeHead(statusCode, {
    "content-type": "text/plain; charset=utf-8",
    "cross-origin-opener-policy": "same-origin",
    "cross-origin-embedder-policy": "require-corp"
  });
  response.end(body);
}

function resolveRequestPath(requestUrl) {
  const parsed = new URL(requestUrl, `http://${host}:${port}`);
  const requestPath = parsed.pathname === "/" ? "/index.html" : decodeURIComponent(parsed.pathname);
  const filePath = normalize(join(webRoot, requestPath));
  if (!filePath.startsWith(webRoot + sep) && filePath !== webRoot) {
    return null;
  }
  return filePath;
}

if (!existsSync(join(webRoot, "index.html"))) {
  console.error(`Missing Godot web export at ${webRoot}. Run npm run web:export first.`);
  process.exit(1);
}

const server = createServer((request, response) => {
  const filePath = resolveRequestPath(request.url ?? "/");
  if (filePath == null || !existsSync(filePath) || !statSync(filePath).isFile()) {
    sendResponse(response, 404, "Not found");
    return;
  }

  response.writeHead(200, {
    "content-type": contentTypes[extname(filePath)] ?? "application/octet-stream",
    "cross-origin-opener-policy": "same-origin",
    "cross-origin-embedder-policy": "require-corp",
    "cross-origin-resource-policy": "same-origin",
    "cache-control": "no-store"
  });
  createReadStream(filePath).pipe(response);
});

server.listen(port, host, () => {
  console.log(`Serving OceanGame web export at http://${host}:${port}/ from ${webRoot}`);
});
