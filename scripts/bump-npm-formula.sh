#!/usr/bin/env bash
# Bump an npm-backed formula to a published version and open a pull request for it.
#
#   scripts/bump-npm-formula.sh <formula> [version]
#
# The version defaults to the package's npm `latest` dist-tag, and any other version is refused:
# the tap ships stable releases only, and a prerelease is published under a different tag.
# The PR is opened by you, not by a workflow, so `brew test-bot` runs on it; once it is green,
# publish it with the "brew pr-pull" workflow (see README.md).
#
# Needs: git, gh (authenticated), npm, curl, and sha256sum or shasum.
set -euo pipefail

die() {
  echo "error: $*" >&2
  exit 1
}

if [[ $# -lt 1 || $# -gt 2 ]]
then
  echo "usage: ${0} <formula> [version]" >&2
  exit 2
fi

formula="${1}"
repo_root="$(git rev-parse --show-toplevel)"
file="Formula/${formula}.rb"
cd "${repo_root}"
[[ -f "${file}" ]] || die "${file} not found"

[[ -z "$(git status --porcelain)" ]] || die "working tree is not clean"
[[ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]] || die "run this from main"
git pull --ff-only --quiet

current_url="$(sed -n 's/^  url "\(.*\)"$/\1/p' "${file}")"
[[ "${current_url}" == https://registry.npmjs.org/*/-/*.tgz ]] || die "${file} does not have an npm registry url (found: '${current_url}')"
package="${current_url#https://registry.npmjs.org/}"
package="${package%%/-/*}"
tarball_base="${package##*/}" # npm names the tarball after the unscoped package name

latest="$(npm view "${package}" dist-tags.latest)"
version="${2:-${latest}}"
[[ "${version}" == "${latest}" ]] || die "${version} is not the npm latest dist-tag of ${package} (latest is ${latest})"

new_url="https://registry.npmjs.org/${package}/-/${tarball_base}-${version}.tgz"
if [[ "${new_url}" == "${current_url}" ]]
then
  echo "${formula} is already at ${version}"
  exit 0
fi

tmp="$(mktemp -d)"
trap 'rm -rf "${tmp}"' EXIT
curl -fsSL -o "${tmp}/pkg.tgz" "${new_url}"
if command -v sha256sum >/dev/null
then
  sha="$(sha256sum "${tmp}/pkg.tgz" | cut -d' ' -f1)"
else
  sha="$(shasum -a 256 "${tmp}/pkg.tgz" | cut -d' ' -f1)"
fi

sed -e "s|^  url \".*\"$|  url \"${new_url}\"|" \
  -e "s|^  sha256 \".*\"$|  sha256 \"${sha}\"|" \
  "${file}" >"${tmp}/formula.rb"
grep -qF "  url \"${new_url}\"" "${tmp}/formula.rb" || die "failed to rewrite url in ${file}"
grep -qF "  sha256 \"${sha}\"" "${tmp}/formula.rb" || die "failed to rewrite sha256 in ${file}"
cp "${tmp}/formula.rb" "${file}"

branch="bump-${formula}-${version}"
title="${formula} ${version}"
git switch --quiet -c "${branch}"
git add -- "${file}"
printf '%s\n' "${title}" >"${tmp}/msg"
git commit --quiet -F "${tmp}/msg"
git push --quiet -u origin "${branch}"

printf 'Bump %s to %s from npm.\n\n- url: %s\n- sha256: %s\n' \
  "${formula}" "${version}" "${new_url}" "${sha}" >"${tmp}/body"
gh pr create --base main --head "${branch}" --title "${title}" --body-file "${tmp}/body"
git switch --quiet main
