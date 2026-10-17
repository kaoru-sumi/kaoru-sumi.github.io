#!/usr/bin/env bash
set -euo pipefail
tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT
bash test/prepare_demo_site.sh "${tmp_dir}/source"
bundle exec jekyll serve --source "${tmp_dir}/source" \
  --config "_config.yml,test/fixtures/demo-site/config.yml,${tmp_dir}/source/demo-excludes.yml" \
  --destination "${tmp_dir}/site" --host 127.0.0.1 --port 4000 --baseurl /al-folio --quiet
