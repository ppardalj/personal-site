dev:
	hugo server --watch --verbose

publish:
	HUGO_ENV=production hugo --minify --verbose
