import {

  OPEN_SURFACE,

  SOLID,

  gridCell,

  rasterizeSolidRects,

  rectCellsFromHook,

} from "./grid-helpers.mjs";



export function colorForCell(cell) {
  if (cell === SOLID) {
    return "#6d7677";
  }
  if (cell === OPEN_SURFACE) {
    return "#6eddf2";
  }
  return "#f6fbff";
}

export function hookColor(type) {
  return {
    oxygen: "#00d9ff",
    offload: "#ff9900",
    player_start: "#ffe04a",
    pickup: "#25c48c",
    scan: "#4fa3ff",
    gate: "#ff4559",
    return_current: "#a26cff",
    hazard: "#ffcc33",
  }[type] ?? "#ffffff";
}

export function svgHeader(source, title) {
  const scale = 10;
  const width = source.width * scale;
  const height = source.height * scale;
  return [
    `<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${source.width} ${source.height}">`,
    `<rect x="0" y="0" width="${source.width}" height="${source.height}" fill="#d6f3ff"/>`,
    `<text x="1" y="2" font-family="monospace" font-size="1.2" fill="#0b2c38">${title}</text>`,
  ];
}

export function drawHooksAndReviewPoints(source, lines) {
  for (const hook of source.hooks ?? []) {
    const rect = rectCellsFromHook(hook);
    const [x, y, width, height] = rect;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="${hookColor(hook.type)}" opacity="0.82" stroke="#06191f" stroke-width="0.08"/>`);
    lines.push(`<text x="${x + 0.1}" y="${y + 0.7}" font-family="monospace" font-size="0.72" fill="#06191f">${hook.id}</text>`);
  }
  for (const point of source.review_points ?? []) {
    const [x, y] = point.cell;
    lines.push(`<circle cx="${x + 0.5}" cy="${y + 0.5}" r="0.28" fill="#111111" opacity="0.75"/>`);
  }
}

export function sourcePreviewSvg(source) {
  const lines = svgHeader(source, "Area 01 source grid");
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      lines.push(`<rect x="${x}" y="${y}" width="1" height="1" fill="${colorForCell(gridCell(source, x, y))}" stroke="#12343d" stroke-width="0.02"/>`);
    }
  }
  drawHooksAndReviewPoints(source, lines);
  lines.push("</svg>");
  return `${lines.join("\n")}\n`;
}

export function runtimePreviewSvg(source, runtime) {
  const lines = svgHeader(source, "Area 01 generated runtime geometry");
  lines.push(`<rect x="0" y="0" width="${source.width}" height="${source.height}" fill="#6eddf2" opacity="0.4"/>`);
  for (const terrain of runtime.solid_terrain) {
    const [x, y, width, height] = terrain.source_cells;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="#526264" opacity="0.88" stroke="#0a2027" stroke-width="0.06"/>`);
  }
  for (const cutout of runtime.source_grid_water_cutouts ?? []) {
    const [x, y, width, height] = cutout.source_cells;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="#d8f6ff" opacity="0.56" stroke="#00c9ff" stroke-width="0.035"/>`);
  }
  for (const region of runtime.playable_water_regions) {
    const [x, y, width, height] = region.source_rect_cells;
    lines.push(`<rect x="${x}" y="${y}" width="${width}" height="${height}" fill="none" opacity="0.4" stroke="#00c9ff" stroke-width="0.1" stroke-dasharray="0.45 0.22"/>`);
  }
  for (const edge of runtime.source_grid_water_edges ?? []) {
    const [start, finish] = edge.points;
    lines.push(`<line x1="${start[0] / source.cell_size}" y1="${start[1] / source.cell_size}" x2="${finish[0] / source.cell_size}" y2="${finish[1] / source.cell_size}" stroke="#06262d" stroke-width="0.08" opacity="0.48"/>`);
  }
  drawHooksAndReviewPoints(source, lines);
  lines.push("</svg>");
  return `${lines.join("\n")}\n`;
}

export function diffPreviewSvg(source, runtime) {
  const lines = svgHeader(source, "Area 01 source/runtime diff");
  const solidRects = runtime.solid_terrain.map((terrain) => terrain.source_cells);
  const raster = rasterizeSolidRects(source, solidRects);
  for (let y = 0; y < source.height; y += 1) {
    for (let x = 0; x < source.width; x += 1) {
      const expected = gridCell(source, x, y) === SOLID;
      const actual = raster[y][x];
      let fill = "#f6fbff";
      if (expected && actual) {
        fill = "#657174";
      } else if (expected && !actual) {
        fill = "#ff3b30";
      } else if (!expected && actual) {
        fill = "#ffcc00";
      } else if (gridCell(source, x, y) === OPEN_SURFACE) {
        fill = "#6eddf2";
      }
      lines.push(`<rect x="${x}" y="${y}" width="1" height="1" fill="${fill}" stroke="#12343d" stroke-width="0.02"/>`);
    }
  }
  lines.push(`<text x="1" y="${source.height - 1}" font-family="monospace" font-size="1" fill="#0b2c38">red=missing solid yellow=extra solid gray=matched solid</text>`);
  lines.push("</svg>");
  return `${lines.join("\n")}\n`;
}
