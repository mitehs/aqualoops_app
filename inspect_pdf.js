const fs = require('fs');
const zlib = require('zlib');

const path = process.argv[2];
const buf = fs.readFileSync(path);
const s = buf.toString('latin1');

console.log('SIZE:', buf.length);
console.log('HEADER:', s.slice(0, 20));

// Count objects
const objs = [...s.matchAll(/(\d+) 0 obj/g)];
console.log('OBJ COUNT (gen0):', objs.length);

// Look for AcroForm / Fields
for (const kw of ['AcroForm', '/FT', '/Tx', '/Btn', '/Field', '/NeedAppearances', '/DR', 'xref', 'ObjStm', 'FlateDecode']) {
  const c = (s.match(new RegExp(kw.replace('/', '\\/'), 'g')) || []).length;
  console.log(`KW ${kw}: ${c}`);
}

// Print the trailer
const tIdx = s.lastIndexOf('trailer');
if (tIdx >= 0) console.log('TRAILER:', s.slice(tIdx, tIdx + 600));

// Print startxref
const xIdx = s.lastIndexOf('startxref');
if (xIdx >= 0) console.log('STARTXREF:', s.slice(xIdx, xIdx + 60));

// Find AcroForm dict
const aIdx = s.indexOf('/AcroForm');
if (aIdx >= 0) console.log('ACROFORM CTX:', s.slice(Math.max(0, aIdx - 300), aIdx + 500));

// List all objects with their dicts (first 400 chars each) - truncated
console.log('\n=== OBJECTS ===');
let re = /(\d+) (\d+) obj/g, m;
let n = 0;
while ((m = re.exec(s)) && n < 200) {
  const start = m.index;
  const snippet = s.slice(start, Math.min(start + 400, s.length));
  // Only show objects that look like dicts (not streams) or show dict header of streams
  const hasStream = /stream\r?\n/.test(s.slice(start, start + 600));
  console.log(`--- obj ${m[1]} ${m[2]} ${hasStream ? '[STREAM]' : ''}`);
  console.log(snippet.replace(/\r?\n/g, '\\n').slice(0, 300));
  n++;
}
