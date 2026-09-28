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
   package's npm `latest` version, downloads the tarball, rewrites `url` and `sha256`, and opens a
   pull request. Pass a version as the second argument to be explicit; anything other than npm
   `latest` is refused, so prereleases never reach the tap.
2. **Test.** The pull request runs `brew test-bot` (`.github/workflows/tests.yml`) on macOS and
   Linux: audit, install from source, `brew test`, and bottle build.
3. **Publish.** When the pull request is green, run the **brew pr-pull** workflow
   (`.github/workflows/publish.yml`) from the Actions tab with the pull request number. It uploads
   the bottles to a GitHub release, adds the bottle block to the formula, and pushes to `main`.
   Don't merge the pull request with the GitHub button — that skips the bottles.

A new formula follows the same route: add `Formula/<name>.rb` on a branch and open a pull request.
Pushes to `main` only run the syntax check, so a formula that never went through a pull request has
never been installed by CI.

Dependabot keeps the pinned GitHub Actions current.
