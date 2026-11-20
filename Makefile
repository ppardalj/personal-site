HUGO_VERSION := $(shell cat .hugo-version)

check-hugo:
	@hugo version | grep -q "v$(HUGO_VERSION)-" || { echo "Local Hugo is not v$(HUGO_VERSION) (.hugo-version): $$(hugo version)"; exit 1; }

dev: check-hugo
	hugo server --watch --logLevel info

publish: check-hugo
	HUGO_ENV=production hugo --minify --logLevel info
