// Sirve la web estática y lee los archivos del Storage con la identidad administrada.
const http = require('node:http');
const fs = require('node:fs/promises');
const path = require('node:path');
const { DefaultAzureCredential } = require('@azure/identity');
const { BlobServiceClient } = require('@azure/storage-blob');

const PORT = process.env.PORT || 8080;
const container = new BlobServiceClient(process.env.STORAGE_ACCOUNT_URL, new DefaultAzureCredential())
  .getContainerClient(process.env.CONTAINER_NAME || 'mensajes');

const PUBLIC_DIR = path.join(__dirname, 'public');
const TYPES = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css' };

async function listFiles(res) {
  const names = [];
  for await (const blob of container.listBlobsFlat()) names.push(blob.name);
  res.writeHead(200, { 'Content-Type': 'application/json' }).end(JSON.stringify(names));
}

async function readFile(res, name) {
  const buffer = await container.getBlobClient(name).downloadToBuffer();
  res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' }).end(buffer);
}

async function serveStatic(res, urlPath) {
  const file = path.join(PUBLIC_DIR, urlPath === '/' ? 'index.html' : urlPath);
  if (!file.startsWith(PUBLIC_DIR)) return res.writeHead(404).end();
  const body = await fs.readFile(file);
  res.writeHead(200, { 'Content-Type': `${TYPES[path.extname(file)] || 'application/octet-stream'}; charset=utf-8` }).end(body);
}

http.createServer(async (req, res) => {
  const { pathname } = new URL(req.url, 'http://localhost');
  try {
    if (pathname === '/api/files') return await listFiles(res);
    if (pathname.startsWith('/api/files/')) return await readFile(res, decodeURIComponent(pathname.slice(11)));
    return await serveStatic(res, pathname);
  } catch (err) {
    console.error(err.message);
    res.writeHead(err.statusCode === 404 || err.code === 'ENOENT' ? 404 : 500).end();
  }
}).listen(PORT, () => console.log(`Escuchando en ${PORT}`));
