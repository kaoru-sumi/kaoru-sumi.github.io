#!/usr/bin/env bash
set -euo pipefail
# Copy the working tree, including uncommitted changes, into a caller-owned temp dir.
destination="${1:?usage: prepare_demo_site.sh TEMP_DIRECTORY}"
mkdir -p "${destination}"
tar --exclude='./.git' --exclude='./_site' --exclude='./node_modules' --exclude='./vendor' \
  --exclude='./.jekyll-cache' -cf - . | tar -xf - -C "${destination}"
cp -R test/fixtures/demo-site/. "${destination}/"
ruby -rpsych -e '
  cfg = Psych.unsafe_load_file("_config.yml")
  excluded = Array(cfg["exclude"]) - %w[_posts/ _books/ _teachings/]
  excluded << "_pages/about_einstein.md"
  puts({ "exclude" => excluded }.to_yaml)
' >"${destination}/demo-excludes.yml"
