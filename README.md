# Pukeko Robotics Tap

Homebrew formulae published by [Pukeko Robotics](https://github.com/pukeko-robotics). Works with
Homebrew on macOS and Linux.

| Formula | What it is |
|---|---|
| `gaunt-sloth` | [Gaunt Sloth](https://gauntsloth.app) — command-line AI assistant for code review, PR analysis and coding sessions (`gth`) |

## Install

```sh
brew install pukeko-robotics/tap/gaunt-sloth
```

Or `brew tap pukeko-robotics/tap` and then `brew install gaunt-sloth`.

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "pukeko-robotics/tap"
brew "gaunt-sloth"
```

## Maintaining

Formulae are updated by hand; nothing in this repo watches upstream releases.

1. **Bump.** From an up-to-date `main`, run `scripts/bump-npm-formula.sh <formula>`. It takes the
   package's npm `latest` version, downloads the tarball, rewrites `url` and `sha256`, drops the
   old version's bottle block, and opens a pull request. Pass a version as the second argument to be explicit; anything other than npm
   `latest` is refused, so prereleases never reach the tap. Wait at least **24 hours after the npm
   release**: Homebrew installs npm formulae with `--min-release-age=1`, so a younger version fails
   `brew install` with `ETARGET`, and the script refuses it.
2. **Test.** The pull request runs `brew test-bot` (`.github/workflows/tests.yml`) on macOS and
   Linux: audit, install from source, `brew test`, and bottle build. The job fails if test-bot
   skipped or failed any formula; on its own, test-bot only warns about a formula with no bottle.
3. **Merge.** When the pull request is green, merge it with the GitHub merge button. The
   **brew bottle** workflow (`.github/workflows/bottle.yml`) then runs on `main`: it rebuilds the
   bottles on macOS and Linux from what landed, uploads them to a GitHub release, and pushes a
   commit adding the bottle block to the formula. Until that commit lands, the formula installs
   from source. If the workflow fails, re-run it, or run it from the Actions tab with the formula
   names.

A new formula follows the same route: add `Formula/<name>.rb` on a branch and open a pull request.
A formula pushed straight to `main` is still built, tested and bottled by **brew bottle**, but only
after it has landed.

Dependabot keeps the pinned GitHub Actions current.
