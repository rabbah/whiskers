Deploys an HTML site with an AJAX callout to a serverless API.

The site is built with Jekyll and deploys to the Nimbella serverless cloud.
This project also demonstrates how to use Netlify as a proxy to your Nimbella domain to use a custom domain name with SSL.

### Required software
* Install [Jekyll](https://jekyllrb.com/docs/installation/).
* Install [Nimbella CLI](https://docs.nimbella.com/install).

### Configure your Nimbella CLI

A Nimbella account is required to use the Nimbella CLI. You can [create a free account](https://nimbella.com) if necessary.
Configure your CLI using `nim login` or see the [available documentation](https://docs.nimbella.com/nim-cmds/auth).

### Local development and deployment

* Edit [config.template](config.template) to configure for your deployment.
Namely, set the domain name which is used to configure the canonical header in the site HTML.

* Run `nim project deploy .`

### Deploy using Netlify

This project is also configured to deploy with Netlify using the Nimbella plugin for Netlify.
Connect your GitHub repo to Netlify to build and deploy your site on new Git commit.
You will need to edit the `redirects` section in [`netlify.toml`](./netlify.toml#L9) to specify your Nimbella domain name for your project.
