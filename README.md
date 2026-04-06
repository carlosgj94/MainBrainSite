# Main Brain Site

Minimal Hugo site for publishing selected notes from the Obsidian Main Brain vault.

## Structure

- `content/notes/` for shorter evergreen/public notes
- `content/essays/` for longer pieces
- RSS is enabled for home and section pages

## Publish flow

1. Write and refine in the Obsidian vault
2. Move a note into `Main Brain/04 Publish/Ready`
3. Copy/adapt it into this repo under `content/notes/` or `content/essays/`
4. Commit and push to GitHub
5. GitHub Actions builds and deploys the site

## Before publishing

Update `hugo.toml`:
- `baseURL`
- site title
- author name

## Local preview

Requires Hugo installed.

```bash
hugo server
```
