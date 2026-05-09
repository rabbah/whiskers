# whiskers.cat

A QR code generator deployed on [DigitalOcean App Platform + Functions](https://docs.digitalocean.com/products/app-platform/).

Enter any text or URL and get a scannable QR code back instantly.

## How it works

A static HTML frontend calls a serverless Node.js function that generates a QR code using the [`qrcode`](https://www.npmjs.com/package/qrcode) package and returns it as a PNG data URL. The frontend renders it directly in an `<img>` tag.

```
GET /api/default/qr?text=<input>
→ 200 text/html  data:image/png;base64,...
```

## Project structure

```
.do/app.yaml               App Platform app spec
project.yml                DigitalOcean Functions manifest
packages/
  default/
    qr/
      qr.js                Serverless function
      package.json         qrcode dependency
web/
  index.html               Static frontend (no build step)
```

## Deployment

The app is deployed via DigitalOcean App Platform. Every push to `master` triggers an automatic redeploy of both the static site and the function.

See [SETUP.md](SETUP.md) for first-time setup instructions.
