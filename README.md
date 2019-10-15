# Pedro Pardal's personal website

Source code of my personal website, which is accessible in [https://ppardalj.github.io](https://ppardalj.github.io).

## Run

Run the development server:

```
$ hugo server -D
```

Site should be available at [http://localhost:1313/](http://localhost:1313/).

## Deploy

The site is hosted using GitHub user pages, and deploy is set up as described [here](https://gohugo.io/hosting-and-deployment/hosting-on-github/).

After doing a change, just run this to deploy it:

```sh
$ ./deploy.sh "description of the changes"
```

Changes will be visible after a few seconds.
