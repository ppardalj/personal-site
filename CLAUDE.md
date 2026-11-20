# Pedro Pardal personal site (Hugo)

- Design tokens, components and the Figma-screen → template map: `DESIGN.md`. Tokens live in `themes/ppardalj/assets/scss/foundation/_variables.scss`.
- A page is `content/**/*.md`: its `blocks:` list renders `themes/ppardalj/layouts/partials/blocks/<type>.html`. `className` on a block sets the section theme (`light`, `dark`, `dark aurora`).
- Dev server: `make dev`. Production build: `make publish`. A push to `master` deploys.
- Toolchain: Hugo extended at the version in `.hugo-version` (CI and `make` both read it) + Dart Sass. The weekly `Hugo canary` workflow builds with the latest Hugo; when it fails, fix the site before bumping `.hugo-version`.
- Newsletter posts (`content/newsletter/`) are exported from Kit, not written here: follow `operating/newsletter.md` in `~/Projects/exeal/exeal-brain` (script `operating/scripts/kit_web.py`).
