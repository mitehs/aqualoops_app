const http = require('http');
const fs = require('fs');
const path = require('path');
const root = 'C:\\Users\\kotak\\Downloads';
const server = http.createServer((req, res) => {
  const p = path.join(root, decodeURIComponent(req.url.split('?')[0]));
  fs.readFile(p, (err, data) => {
    if (err) { res.writeHead(404); res.end('nf'); return; }
    const ext = path.extname(p).toLowerCase();
    const types = {'.pdf':'application/pdf','.png':'image/png','.jpg':'image/jpeg','.html':'text/html'};
    res.writeHead(200, {'Content-Type': types[ext] || 'application/octet-stream'});
    res.end(data);
  });
});
server.listen(8931, () => console.log('listening 8931'));
