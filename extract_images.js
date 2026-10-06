const fs = require('fs');
const zlib = require('zlib');
const path = process.argv[2];
const outDir = process.argv[3];
const buf = fs.readFileSync(path);
const s = buf.toString('latin1');

const objRe = /(\d+) (\d+) obj\b/g;
const objs = {}; let m;
while ((m = objRe.exec(s))) {
  const num = +m[1];
  if (objs[num] !== undefined) continue;
  const bodyStart = m.index + m[0].length;
  const endIdx = s.indexOf('endobj', bodyStart);
  objs[num] = { dict: s.slice(bodyStart, endIdx > 0 ? endIdx : bodyStart + 3000), off: m.index };
}
function rawStream(num) {
  const o = objs[num]; if (!o) return null;
  const i1 = s.indexOf('stream\r\n', o.off), i2 = s.indexOf('stream\n', o.off);
  const mk = (i2 >= 0 && (i1 < 0 || i2 < i1)) ? i2 : i1;
  if (mk < 0) return null;
  const start = mk + (s[mk+6] === '\r' ? 8 : 7);
  const end = s.indexOf('endstream', start);
  let raw = buf.subarray(start, end);
  if (raw[raw.length-1] === 0x0a) raw = raw.subarray(0, raw.length-1);
  if (raw[raw.length-1] === 0x0d) raw = raw.subarray(0, raw.length-1);
  return {raw, dict: o.dict};
}

function crc32(buf) {
  let c, table = [];
  for (let n = 0; n < 256; n++) { c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; table[n] = c >>> 0; }
  let crc = 0xFFFFFFFF;
  for (let i = 0; i < buf.length; i++) crc = table[(crc ^ buf[i]) & 0xFF] ^ (crc >>> 8);
  return (crc ^ 0xFFFFFFFF) >>> 0;
}
function chunk(type, data) {
  const len = Buffer.alloc(4); len.writeUInt32BE(data.length);
  const td = Buffer.concat([Buffer.from(type, 'ascii'), data]);
  const crc = Buffer.alloc(4); crc.writeUInt32BE(crc32(td));
  return Buffer.concat([len, td, crc]);
}
function toPNG(raw, w, h, ch) {
  const stride = w * ch;
  const rows = Buffer.alloc((stride + 1) * h);
  for (let y = 0; y < h; y++) {
    rows[y * (stride + 1)] = 0;
    raw.copy(rows, y * (stride + 1) + 1, y * stride, (y + 1) * stride);
  }
  const ihdr = Buffer.alloc(13);
  ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4);
  ihdr[8] = 8; ihdr[9] = ch === 4 ? 6 : (ch === 3 ? 2 : 0); ihdr[10] = 0; ihdr[11] = 0; ihdr[12] = 0;
  return Buffer.concat([
    Buffer.from([0x89,0x50,0x4E,0x47,0x0D,0x0A,0x1A,0x0A]),
    chunk('IHDR', ihdr),
    chunk('IDAT', zlib.deflateSync(rows)),
    chunk('IEND', Buffer.alloc(0)),
  ]);
}

for (const num of Object.keys(objs)) {
  const o = objs[num];
  if (!/\/Subtype\s*\/Image/.test(o.dict)) continue;
  const w = +(o.dict.match(/\/Width\s+(\d+)/)||[])[1];
  const h = +(o.dict.match(/\/Height\s+(\d+)/)||[])[1];
  const filter = (o.dict.match(/\/Filter\s*(\/\w+|\[[^\]]*\])/)||[])[1] || '';
  const rs = rawStream(+num); if (!rs) continue;
  const smask = (o.dict.match(/\/SMask\s+(\d+) 0 R/)||[])[1];
  const name = `img_${num}_${w}x${h}${smask ? '_sm'+smask : ''}`;
  if (/DCTDecode/.test(filter)) {
    fs.writeFileSync(`${outDir}\\${name}.jpg`, rs.raw);
    console.log(`${num}: JPEG ${w}x${h} -> ${name}.jpg`);
  } else if (/JPXDecode/.test(filter)) {
    fs.writeFileSync(`${outDir}\\${name}.jp2`, rs.raw);
    console.log(`${num}: JP2 ${w}x${h}`);
  } else if (/FlateDecode/.test(filter) || filter === '') {
    try {
      const dec = zlib.inflateSync(rs.raw);
      const cs = (o.dict.match(/\/ColorSpace\s*(\/\w+)/)||[])[1] || '';
      const bpc = +(o.dict.match(/\/BitsPerComponent\s+(\d+)/)||[])[1] || 8;
      let ch = /DeviceRGB/.test(cs) ? 3 : (/DeviceGray|\/G\b/.test(cs) ? 1 : 0);
      if (!ch) { // try decode based on length
        if (dec.length === w*h*3) ch = 3; else if (dec.length === w*h) ch = 1; else if (dec.length === w*h*4) ch = 4;
      }
      if (ch && dec.length >= w*h*ch && bpc === 8) {
        fs.writeFileSync(`${outDir}\\${name}.png`, toPNG(dec, w, h, ch));
        console.log(`${num}: PNG ${w}x${h} ch=${ch} cs=${cs} -> ${name}.png`);
      } else {
        fs.writeFileSync(`${outDir}\\${name}.raw`, dec);
        console.log(`${num}: RAW ${w}x${h} ch=${ch} bpc=${bpc} len=${dec.length} expected=${w*h*3} -> ${name}.raw`);
      }
    } catch(e) { console.log(`${num}: inflate fail ${e.message}`); }
  } else {
    console.log(`${num}: skip filter=${filter} ${w}x${h}`);
  }
}
