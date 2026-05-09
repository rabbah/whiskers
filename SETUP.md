# Setup Guide

How to deploy this app on DigitalOcean App Platform from scratch.

## Prerequisites

- A [DigitalOcean account](https://cloud.digitalocean.com/)
- The [`doctl` CLI](https://docs.digitalocean.com/reference/doctl/how-to/install/) installed and authenticated
- This repository forked/cloned and pushed to your own GitHub account

### Authenticate doctl

```bash
doctl auth init
```

## Configure the app spec

Before deploying, edit `.do/app.yaml` and update:

- `name` — your app name (lowercase, hyphens only)
- `github.repo` — your GitHub `owner/repo`
- `domains` — your custom domain, or remove the `domains` block to use the default `.ondigitalocean.app` URL

## Deploy

### Option A — DigitalOcean control panel (easiest)

1. Go to **App Platform** → **Create App**
2. Connect your GitHub account and select your repo and branch
3. App Platform will detect the `.do/app.yaml` spec automatically
4. Review the detected components (static site `web`, functions `api`) and click **Create Resources**

### Option B — CLI

Create the app from the spec file:

```bash
doctl apps create --spec .do/app.yaml
```

Check the app was created and note its ID:

```bash
doctl apps list
```

After pushing changes, App Platform redeploys automatically (`deploy_on_push: true`). To trigger a manual deploy:

```bash
doctl apps create-deployment <app-id>
```

## Custom domain

After creating the app:

1. In the App Platform dashboard, go to **Settings → Domains**
2. Copy the CNAME target (e.g. `your-app-xxxxx.ondigitalocean.app`)
3. At your DNS provider, add a CNAME record:
   ```
   your-domain.com  CNAME  your-app-xxxxx.ondigitalocean.app
   ```
4. DigitalOcean provisions a TLS certificate automatically once DNS propagates

## Local function development

Install the `doctl` serverless plugin:

```bash
doctl serverless install
```

Connect to your DO Functions namespace:

```bash
doctl serverless connect
```

Deploy and invoke the function locally:

```bash
doctl serverless deploy .
doctl serverless functions invoke default/qr --param text:hello
```

## Validate the app spec

Before deploying changes to the spec:

```bash
doctl apps spec validate .do/app.yaml
```

## Update a running app

```bash
doctl apps update <app-id> --spec .do/app.yaml
```

## Tail logs

```bash
# Static site build logs
doctl apps logs <app-id> --component web --type build --follow

# Function runtime logs
doctl apps logs <app-id> --component api --type run --follow
```

## How routing works

```
https://your-domain.com/        → web component  (web/index.html)
https://your-domain.com/api/*   → api component  (DO Functions)
```

The function `qr` in package `default` is reachable at:

```
GET /api/default/qr?text=<url-encoded-text>
```

It returns a PNG data URL (`data:image/png;base64,...`) with `Content-Type: text/html`.
