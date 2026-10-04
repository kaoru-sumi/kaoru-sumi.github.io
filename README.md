# Kaoru Sumi — Research Website

Research website of **Kaoru Sumi**, Professor at Future University Hakodate, and the
**Persuasive and Affective Human–AI Interaction (PAHAI) Lab**. It presents research on
affective computing, human–AI interaction, persuasive technology, VR/MR, and serious games,
along with publications, lab information, news, awards, and contact details.

- **English:** https://kaoru-sumi.github.io/
- **日本語:** https://kaoru-sumi.github.io/ja/

## Content and routine updates

| Content                         | Main source files                                                                  |
| ------------------------------- | ---------------------------------------------------------------------------------- |
| Home and profile                | `_pages/about.md` (English), `_pages/home-ja.md` (Japanese)                        |
| Recent activities               | `_news/` (English feed), recent activities in `_pages/home-ja.md` (Japanese)       |
| Research                        | `_pages/projects.md`, `_pages/research-ja.md`, and project details in `_projects/` |
| Publications                    | `_bibliography/papers.bib`; page settings in `_pages/publications.md`              |
| PAHAI Lab                       | `_pages/lab.md`, `_pages/lab-ja.md`                                                |
| Awards                          | `_pages/awards.md`, `_pages/awards-ja.md`                                          |
| Contact                         | `_pages/cv.md` (English contact page), `_pages/contact-ja.md`                      |
| Japanese navigation             | `_data/ja_navigation.yml`                                                          |
| Profile links and site metadata | `_data/socials.yml`, `_config.yml`                                                 |
| Images and downloadable files   | `assets/img/`, `assets/pdf/`                                                       |

Keep corresponding English and Japanese content consistent when updating information.
Publications share one bibliography; there is no separate Japanese publications page.

## Local preview and build

Use Ruby **3.3.5**, Bundler, and Node.js **20** to match the deployment workflow.
Install ImageMagick for responsive images; Python with `nbconvert` supports notebook content.
From the repository root:

```bash
bundle install
npm ci
bundle exec jekyll serve
```

Open http://localhost:4000/ (English) or http://localhost:4000/ja/ (Japanese).
For a production build and formatting check:

```bash
JEKYLL_ENV=production bundle exec jekyll build
npm run lint:prettier
```

Generated files are written to `_site/`. This site uses `url: https://kaoru-sumi.github.io`
and an empty `baseurl` in `_config.yml`; keep the root-path configuration when building.

## Deployment

[Deploy site](.github/workflows/deploy.yml) runs in GitHub Actions for matching changes
on `main` (also configured for `master`) and pull requests targeting those branches,
or when started manually. It installs dependencies, builds Jekyll in production mode,
checks generated page languages, and removes unused CSS. Non-PR runs publish `_site/`
to `gh-pages` for GitHub Pages; pull requests build and validate without publishing.

Edit the source files on a working branch and submit a pull request to this repository.
Do not edit generated files on `gh-pages` directly. `README.md` is excluded from both
Jekyll output and the deployment workflow's automatic path triggers, so a README-only
change does not alter the published website or trigger its deployment.

## al-folio and documentation

This site uses [al-folio](https://github.com/alshedivat/al-folio), a Jekyll academic-site
starter, with `al_folio_core` and versioned plugin gems. Dependencies are defined in
`Gemfile` / `Gemfile.lock`, with plugin activation and site settings in `_config.yml`.

- [Official al-folio documentation](https://github.com/alshedivat/al-folio/tree/main/docs)
- [Repository documentation](docs/README.md)
- [Agent instructions](AGENTS.md)
- [Repository license](LICENSE)

## License

al-folio is available as open source under the terms of the [MIT License](https://github.com/alshedivat/al-folio/blob/main/LICENSE).

Originally, **al-folio** was based on the [\*folio theme](https://github.com/bogoli/-folio) (published by [Lia Bogoev](https://liabogoev.com) and under the MIT license). Since then, it got a full re-write of the styles and many additional cool features.
