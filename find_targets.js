const fs = require('fs');
const zlib = require('zlib');

const path = process.argv[2];
const buf = fs.readFileSync(path);
const s = buf.toString('latin1');

const streams = [];
const re = /(\d+) (\d+) obj([\s\S]*?)stream\r?\n/g;
let m;
while ((m = re.exec(s))) {
  const objNum = +m[1];
  const dict = m[3];
  const streamStart = re.lastIndex;
  const endIdx = s.indexOf('endstream', streamStart);
  if (endIdx < 0) continue;
  let raw = buf.subarray(streamStart, endIdx);
  if (raw[raw.length - 1] === 0x0a) raw = raw.subarray(0, raw.length - 1);
  if (raw[raw.length - 1] === 0x0d) raw = raw.subarray(0, raw.length - 1);
  let data = null;
  if (/FlateDecode/.test(dict)) { try { data = zlib.inflateSync(raw).toString('latin1'); } catch(e){} }
  else data = raw.toString('latin1');
  streams.push({objNum, dict, data, start: streamStart, end: endIdx, raw});
}

const pats = ['KRINA','Krina','krina','KHUNT','Enrollment','ENROLLMENT','enrollment','Female','female','FEMALE','@gmail','gmail','Gender','gender'];
for (const st of streams) {
  if (!st.data) continue;
  for (const p of pats) {
    let i = st.data.indexOf(p);
    while (i >= 0) {
      const ctx = st.data.slice(Math.max(0,i-260), i+260);
      console.log(`obj ${st.objNum} [${p} @${i}]\n   ${JSON.stringify(ctx)}\n`);
      i = st.data.indexOf(p, i + p.length);
    }
  }
}
