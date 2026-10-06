const fs = require('fs');
const zlib = require('zlib');
const path = process.argv[2];
const buf = fs.readFileSync(path);
const s = buf.toString('latin1');

// proper object parser
const objRe = /(\d+) (\d+) obj\b/g;
const objs = {};
let m;
while ((m = objRe.exec(s))) {
  const num = +m[1];
  if (objs[num]) continue;
  const bodyStart = m.index + m[0].length;
  const endIdx = s.indexOf('endobj', bodyStart);
  objs[num] = { num, dict: s.slice(bodyStart, endIdx > 0 ? endIdx : bodyStart + 2000), off: m.index };
}

function getStream(num) {
  const o = objs[num]; if (!o) return null;
  const si = o.dict.search(/stream\r?\n/);
  if (si < 0) return null;
  const dataStart = o.off + o.dict.indexOf('stream\r\n'.replace('\r\n','\r\n')) ; // fallback
  return null;
}

// simpler: find streams by object using raw index
function streamData(num) {
  const o = objs[num]; if (!o) return null;
  const rel = o.dict.search(/stream\r?\n/);
  if (rel < 0) return null;
  const abs = o.off + 6 + rel; // "N 0 obj" length varies; recompute
  const marker = s.indexOf('stream\r\n', o.off);
  const marker2 = s.indexOf('stream\n', o.off);
  const mk = (marker2 >= 0 && (marker < 0 || marker2 < marker)) ? marker2 : marker;
  if (mk < 0) return null;
  const start = mk + (s[mk + 6] === '\r' ? 8 : 7);
  const end = s.indexOf('endstream', start);
  let raw = buf.subarray(start, end);
  if (raw[raw.length-1] === 0x0a) raw = raw.subarray(0, raw.length-1);
  if (raw[raw.length-1] === 0x0d) raw = raw.subarray(0, raw.length-1);
  if (/FlateDecode/.test(o.dict)) { try { return zlib.inflateSync(raw).toString('latin1'); } catch(e){ return null; } }
  return raw.toString('latin1');
}

function unescapePdf(str) {
  return str.replace(/\\([nrtbf()\\]|[0-7]{1,3})/g, (a, b) => {
    if (b === 'n') return '\n'; if (b === 'r') return '\r'; if (b === 't') return '\t';
    if (b === 'b') return '\b'; if (b === 'f') return '\f';
    if (b === '(' || b === ')' || b === '\\') return b;
    return String.fromCharCode(parseInt(b, 8));
  });
}

// pages: order of page objects from Pages kids
const pagesKids = (objs[2].dict.match(/\/Kids\[\s*([\s\S]*?)\]/) || [])[1] || '';
const pageNums = [...pagesKids.matchAll(/(\d+) 0 R/g)].map(x => +x[1]);

pageNums.forEach((pn, idx) => {
  const pd = objs[pn] ? objs[pn].dict : '';
  const cm = pd.match(/\/Contents\s+(\d+) 0 R/);
  if (!cm) { console.log(`\n===== PAGE ${idx+1} (obj ${pn}) no contents =====`); return; }
  const data = streamData(+cm[1]);
  if (!data) { console.log(`\n===== PAGE ${idx+1} fail =====`); return; }
  const lines = [];
  const opRe = /\[((?:[^\[\]\\]|\\.)*)\]\s*TJ|\(((?:[^()\\]|\\.)*)\)\s*Tj|1 0 0 1 ([-\d.]+) ([-\d.]+) Tm/g;
  let o; let cur = '';
  while ((o = opRe.exec(data))) {
    if (o[3] !== undefined) { if (cur) lines.push(cur); cur = `@(${o[3]},${o[4]}) `; continue; }
    const inner = o[1] !== undefined ? o[1] : o[2];
    const strRe = /\(((?:[^()\\]|\\.)*)\)|(-?[\d.]+)/g;
    let sm, txt = '';
    while ((sm = strRe.exec(inner))) { if (sm[1] !== undefined) txt += unescapePdf(sm[1]); }
    cur += txt;
  }
  if (cur) lines.push(cur);
  console.log(`\n===== PAGE ${idx+1} (page obj ${pn}, content ${cm[1]}) =====`);
  console.log(lines.join('\n'));
});
