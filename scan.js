const fs = require('fs');
const zlib = require('zlib');
const path = process.argv[2];
const buf = fs.readFileSync(path);
const s = buf.toString('latin1');

// proper object map
const objRe = /(\d+) (\d+) obj\b/g;
const objs = {}; let m;
while ((m = objRe.exec(s))) {
  const num = +m[1];
  if (objs[num] !== undefined) continue;
  const bodyStart = m.index + m[0].length;
  const endIdx = s.indexOf('endobj', bodyStart);
  objs[num] = { dict: s.slice(bodyStart, endIdx > 0 ? endIdx : bodyStart + 3000), off: m.index };
}
function streamData(num) {
  const o = objs[num]; if (!o) return null;
  const i1 = s.indexOf('stream\r\n', o.off), i2 = s.indexOf('stream\n', o.off);
  const mk = (i2 >= 0 && (i1 < 0 || i2 < i1)) ? i2 : i1;
  if (mk < 0) return null;
  const start = mk + (s[mk+6] === '\r' ? 8 : 7);
  const end = s.indexOf('endstream', start);
  let raw = buf.subarray(start, end);
  if (raw[raw.length-1] === 0x0a) raw = raw.subarray(0, raw.length-1);
  if (raw[raw.length-1] === 0x0d) raw = raw.subarray(0, raw.length-1);
  if (/FlateDecode/.test(o.dict)) { try { return zlib.inflateSync(raw).toString('latin1'); } catch(e){ return null; } }
  return raw.toString('latin1');
}

// pages
const kids = (objs[2].dict.match(/\/Kids\[\s*([\s\S]*?)\]/)||[])[1]||'';
const pageNums = [...kids.matchAll(/(\d+) 0 R/g)].map(x=>+x[1]);

console.log('=== IMAGES PER PAGE + HEX TEXT ===');
pageNums.forEach((pn, idx) => {
  const d = objs[pn].dict;
  const xo = (d.match(/\/XObject\s*<<([^>]*)>>/)||[])[1] || '';
  const refs = [...xo.matchAll(/\/(\w+)\s+(\d+) 0 R/g)];
  const imgs = [];
  for (const [,name,ref] of refs) {
    const od = objs[+ref] ? objs[+ref].dict : '';
    if (/\/Subtype\s*\/Image/.test(od)) {
      const w = (od.match(/\/Width\s+(\d+)/)||[])[1];
      const h = (od.match(/\/Height\s+(\d+)/)||[])[1];
      imgs.push(`${name}(${ref}) ${w}x${h}`);
    }
  }
  const cm = (d.match(/\/Contents\s+(\d+) 0 R/)||[])[1];
  const data = cm ? streamData(+cm) : null;
  let hex = 0, tj = 0;
  if (data) { hex = (data.match(/<[0-9A-Fa-f\s]+>\s*Tj/g)||[]).length; tj = (data.match(/\[[^\]]*\]\s*TJ/g)||[]).length; }
  console.log(`page ${idx+1}: imgs=[${imgs.join(', ')}] hexTj=${hex} TJ=${tj}`);
});

// Global search across ALL content streams for target strings
console.log('\n=== TARGET SEARCH (all streams, correct parse) ===');
const targets = ['KHUNT','Khunt','krina','KRINA','13033','13034','Female','Male','6353050513','gmail.com','Kotak','Nikhil'];
pageNums.forEach((pn, idx) => {
  const d = objs[pn].dict;
  const cm = (d.match(/\/Contents\s+(\d+) 0 R/)||[])[1];
  if (!cm) return;
  const data = streamData(+cm); if (!data) return;
  for (const t of targets) {
    let i = data.indexOf(t);
    while (i >= 0) { console.log(`page ${idx+1} [${t}] ctx=${JSON.stringify(data.slice(Math.max(0,i-80), i+80))}`); i = data.indexOf(t, i+t.length); }
  }
});
