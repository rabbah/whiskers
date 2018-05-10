Deploys a simple HTML site with an AJAX callout to a backend function.

* Install [Jekyll](https://jekyllrb.com/docs/installation/).
* Install [wsk](https://github.com/apache/incubator-openwhisk-cli/releases), the OpenWhisk CLI.
* Edit [config.template](config.template) to configure for your deployment.
* Run `./do.sh --deploy` to generate `config.yml`, deploy the actions, and build the site with `jekyll`.

Connect the GitHub repository to your [Netlify](netlify.com) account to continuously deploy.
Use the Netlify dashboard to define the environment variables:
* `WSK_API_HOST`: the OpenWhisk API host
* `WSK_API_KEY`: your OpenWhisk API key
