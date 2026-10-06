const fs = require('fs');
const zlib = require('zlib');

const path = process.argv[2];
const buf = fs.readFileSync(path);
const s = buf.toString('latin1');

// Find all "N G obj ... stream ... endstream"
const out = [];
const re = /(\d+) (\d+) obj([\s\S]*?)stream\r?\n/g;
let m;
while ((m = re.exec(s))) {
  const objNum = +m[1];
  const dictStart = m.index;
  const dict = m[3];
  const streamStart = re.lastIndex;
  const endIdx = s.indexOf('endstream', streamStart);
  if (endIdx < 0) continue;
  let raw = buf.subarray(streamStart, endIdx);
  // strip one trailing EOL
  if (raw[raw.length - 1] === 0x0a) raw = raw.subarray(0, raw.length - 1);
  if (raw[raw.length - 1] === 0x0d) raw = raw.subarray(0, raw.length - 1);
  if (!/FlateDecode/.test(dict)) { out.push({objNum, dict, data: raw.toString('latin1'), raw}); continue; }
  try {
    const dec = zlib.inflateSync(raw);
    out.push({objNum, dict, data: dec.toString('latin1'), raw: dec});
  } catch (e) {
    out.push({objNum, dict, data: null, err: e.message, raw});
  }
}

console.log('STREAMS:', out.length);
const needles = ['krina', 'Krina', 'KRINA', 'enroll', 'Enroll', 'gender', 'Gender', 'contact', 'Contact', 'email', 'Email', 'mail'];
for (const st of out) {
  if (!st.data) continue;
  const hits = needles.filter(n => st.data.includes(n));
  if (hits.length) {
    console.log(`\n### obj ${st.objNum} hits=${JSON.stringify(hits)} len=${st.data.length}`);
    for (const h of hits) {
      let i = st.data.indexOf(h);
      while (i >= 0) {
        console.log(`  [${h} @${i}] ...${JSON.stringify(st.data.slice(Math.max(0, i - 200), i + 200))}...`);
        i = st.data.indexOf(h, i + 1);
      }
    }
  }
}
