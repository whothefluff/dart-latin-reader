# Data & builds

**Contributors** (working from a fork) need no keys or secrets. Local builds work out of the box. Anything marked **Owner** is for the repo owner, and you can skip it.

## The basics

The app reads everything (texts, dictionary, frequencies) from one database file, `data.db`. That file is made from the CSVs in `assets/preprocessed_data/`.

Who generates it depends on the build:

| Build | Who creates `data.db` | When |
| --- | --- | --- |
| Local build (`flutter run` / `flutter build`) | The app itself, from the CSVs | First launch (slow) |
| Build from GitHub | GitHub. It ships inside the app **instead** of the CSVs | During the build. Fast launch |

## Changing CSV files

1. Edit the CSV.
2. Increase the number in `data_version.txt` by 1.
3. Commit and open a PR. GitHub rebuilds the database. Can fail from DB constraints.

Step 2 is for local builds. Those apps already have a `data.db` from an earlier launch. On every launch they compare `data_version.txt` with the number stored inside `data.db`, and only read the CSVs again when the file's number is higher. Skip the bump and they keep showing the old data.

Builds from GitHub don't need it: they get a new `data.db` whenever the data changes.

## Changing DB schema

Local builds refill data but never change the tables in an existing `data.db`. Delete it once and the next launch makes a new one:

- **Android:** Settings → Apps → latin_reader → Storage → **Clear cache**.
- **Windows:** delete `%LOCALAPPDATA%\com.magnetys\latin_reader\data.db`.
- **Linux:** delete `~/.cache/com.magnetys.latin_reader/data.db`.
- **macOS:** delete `~/Library/Containers/com.magnetys.latinReader/Data/Library/Caches/com.magnetys.latinReader/data.db`.

Your settings live elsewhere, so they survive. Builds from GitHub need nothing.

## Getting the app from GitHub

### Everyone

| Latest main | App | Its database |
| --- | --- | --- |
| Android | [APK](https://github.com/whothefluff/dart-latin-reader/releases/download/android-preview/app-release.apk) | [`data.db`](https://github.com/whothefluff/dart-latin-reader/releases/download/android-preview/data.db) |
| Windows | [ZIP](https://github.com/whothefluff/dart-latin-reader/releases/download/windows-preview/latin-reader-windows.zip) | [`data.db`](https://github.com/whothefluff/dart-latin-reader/releases/download/windows-preview/data.db) |
| Linux | [tarball](https://github.com/whothefluff/dart-latin-reader/releases/download/linux-preview/latin-reader-linux.tar.gz) | [`data.db`](https://github.com/whothefluff/dart-latin-reader/releases/download/linux-preview/data.db) |
| macOS | [ZIP](https://github.com/whothefluff/dart-latin-reader/releases/download/macos-preview/latin-reader-macos.zip) | [`data.db`](https://github.com/whothefluff/dart-latin-reader/releases/download/macos-preview/data.db) |
| iOS | [IPA, unsigned](https://github.com/whothefluff/dart-latin-reader/releases/download/ios-preview/latin-reader-ios-unsigned.ipa) | [`data.db`](https://github.com/whothefluff/dart-latin-reader/releases/download/ios-preview/data.db) |

- **Android** installs as **Latin Reader Preview**, separate from your local build.
- **Windows:** unzip it and run `latin_reader\latin_reader.exe`.
- **Linux:** extract it and run `latin_reader/latin_reader`. It needs GTK 3, which desktop distros already have.
- **macOS:** unzip it, run `xattr -dr com.apple.quarantine latin_reader.app` once (the app isn't notarized, so macOS blocks it otherwise), then open it.
- **iOS:** the IPA is unsigned, so iOS won't install it as is. Sign and install it with your Apple ID through a sideloading tool such as AltStore or Sideloadly. With a free Apple ID the app stops opening after 7 days, until you install it again.
- **Windows, Linux and macOS** share settings with your local build on the same OS, but not data: they keep their own database.

Each `data.db` is the exact file packaged inside that build, for opening in an SQLite browser. The pre-release pages ([Android](https://github.com/whothefluff/dart-latin-reader/releases/tag/android-preview), [Windows](https://github.com/whothefluff/dart-latin-reader/releases/tag/windows-preview), [Linux](https://github.com/whothefluff/dart-latin-reader/releases/tag/linux-preview), [macOS](https://github.com/whothefluff/dart-latin-reader/releases/tag/macos-preview), [iOS](https://github.com/whothefluff/dart-latin-reader/releases/tag/ios-preview)) say when each build was made (UTC), from which commit, and the database's data version and SHA-256. The date GitHub shows next to the title is when the pre-release was first created, not the latest build.

### Updating

**Installing over the old build is enough. No uninstall needed**, not even when the data or the DB schema changed. Every build from GitHub carries its own `data.db`: on its first launch it copies it to `bundled-data-<SHA-256>.db` in the app's data folder and deletes the previous build's copy. Settings survive.

- **Android preview:** install the new APK over the old one.
- **Windows and Linux:** delete the old `latin_reader` folder and extract the new one in its place. Extracting on top also works, but can leave behind files the new build no longer has.
- **macOS:** replace `latin_reader.app` with the new one, and run the `xattr` command again.
- **iOS:** sign and install the new IPA the same way; it installs over the old app.

The installed copy, `bundled-data-<SHA-256>.db`, is in:

- **Windows:** `%APPDATA%\com.magnetys\latin_reader\`
- **Linux:** `~/.local/share/com.magnetys.latin_reader/`
- **macOS:** `~/Library/Containers/com.magnetys.latinReader/Data/Library/Application Support/com.magnetys.latinReader/`

Desktop builds from GitHub (preview, PR, branch) share that folder, so launching a different one swaps in its own copy.

The one exception is Android PR builds (below), and only because of signing, not the database.

### Contributors: from your PR

Every PR run produces downloadable builds. Open the run from your PR's checks and scroll to **Artifacts**.

- **Android:** download `latin-reader-apk-<number>`, a ZIP. Unzip it and install `app-release.apk`. It installs as **Latin Reader PR**.
  - Each PR build is signed with a throwaway key, so uninstall the previous Latin Reader PR before installing a newer one.
- **Windows:** download `latin-reader-windows-<number>`, a ZIP of the whole app folder. Unzip it and run `latin_reader.exe`; the other files next to it are required.
- **Linux:** download `latin-reader-linux-<number>`, a ZIP holding `latin-reader-linux.tar.gz` (a tarball keeps the app's executable bit). Extract both and run `latin_reader/latin_reader`.
- **macOS:** download `latin-reader-macos-<number>`, a ZIP holding `latin-reader-macos.zip` (the inner ZIP keeps the app's signature and permissions). Unzip both, then run the `xattr` command above.
- **iOS:** download `latin-reader-ios-<number>`, a ZIP holding `latin-reader-ios-unsigned.ipa`. Sign and install it as above.
- **Database:** download `latin-reader-database-<number>`, a ZIP with the `data.db` packaged in that run's builds.

If GitHub Actions is enabled in your fork, runs there build the same way PR builds do (the APK installs as Latin Reader PR) and publish nothing. The checks that count are the ones on your PR here.

### Owner: any branch

Starting a workflow by hand needs write access to the repo.

Run `gh workflow run ci.yml --ref <branch>`. It builds every platform; download what you need from that run:

- **Android:** `latin-reader-apk-<number>`. It installs as **Latin Reader Preview**, over the current preview.
- **Windows:** `latin-reader-windows-<number>`.
- **Linux:** `latin-reader-linux-<number>`.
- **macOS:** `latin-reader-macos-<number>`.
- **iOS:** `latin-reader-ios-<number>`.
- **Database:** `latin-reader-database-<number>`.

Only runs on main update the pre-releases.

## Version numbers

- **Build number:** set automatically on Android builds to the CI run number. Nothing to do.
- **Visible version (`1.0.0`):** the part before `+` in `version:` in `pubspec.yaml`. Change it by hand.

## Owner only: required checks

Set in the branch ruleset for main. Require **Checks**, **Database**, **Android / Build** and **Windows / Build**. Leave **Linux / Build**, **macOS / Build** and **iOS / Build** off: when they fail, the PR shows it, but they never block the merge.

**Checks** and **Database** have to be on the list: when either fails, the platform builds are skipped, and GitHub counts a skipped required check as passed.

## Owner only: signing key and secrets

Android only installs an update if it's signed with the same key as the installed app. Preview APKs (from main or from branches run by hand) use one fixed key, stored in two repository secrets:

- `ANDROID_TEST_KEYSTORE_BASE64`
- `ANDROID_TEST_KEYSTORE_PASSWORD`

PR builds, including contributors', never use them.

- Keep a backup of the `.jks` file and its password outside the repo.
- If I lose them:
  1. Make a new key with alias `latin-reader-test`.
  2. Replace both secrets.
  3. Uninstall the preview app once.
- NOTE: Not a Play Store key. Windows, Linux and macOS builds aren't signed with a developer identity: macOS only gets the ad-hoc signature it needs to run, hence the `xattr` step. iOS builds aren't signed at all: the sideloading tool signs them with your Apple ID.

A PR from a first-time contributor may wait for my approval: open the run in the Actions tab and choose **Approve and run**.