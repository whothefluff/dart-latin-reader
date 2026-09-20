# Data & builds

**Contributors** (working from a fork) need no keys or secrets. Local builds work out of the box. Anything marked **Owner** is for the repo owner, and you can skip it.

## The basics

The app reads everything (texts, dictionary, frequencies) from one database file, `data.db`. That file is made from the CSVs in `assets/preprocessed_data/`.

Who generates it depends on the build:

| Build | Who creates `data.db` | When |
| --- | --- | --- |
| Local build, Android or Windows (`flutter run` / `flutter build`) | The app itself, from the CSVs | First launch (slow) |
| Windows build from GitHub | The app itself, from the CSVs | First launch (slow) |
| Android APK from GitHub | GitHub. It ships inside the APK **instead** of the CSVs | During the build. Fast launch |

## Changing CSV files

1. Edit the CSV.
2. Increase the number in `data_version.txt` by 1.
3. Commit and open a PR. GitHub rebuilds the database. Can fail from DB constraints.

Step 2 is for builds where the app makes `data.db` itself: local builds and Windows builds from GitHub. Those apps already have a `data.db` from an earlier launch. On every launch they compare `data_version.txt` with the number stored inside `data.db`, and only read the CSVs again when the file's number is higher. Skip the bump and they keep showing the old data.

Android APKs from GitHub don't need it: they get a new `data.db` whenever the data changes.

## Changing DB schema

Apps that make `data.db` themselves refill data but never change the tables in an existing `data.db`. Delete it once and the next launch makes a new one:

- **Android:** Settings → Apps → latin_reader → Storage → **Clear cache**.
- **Windows:** delete `%LOCALAPPDATA%\com.magnetys\latin_reader\data.db`.

Your settings live elsewhere, so they survive. Android APKs from GitHub need nothing.

## Getting the app from GitHub

### Everyone

- **Latest main, Android:** [download the APK](https://github.com/whothefluff/dart-latin-reader/releases/download/android-preview/app-release.apk). It installs as **Latin Reader Preview**, separate from your local build. New previews install over old ones and keep their settings.
- **Latest main, Windows:** [download the ZIP](https://github.com/whothefluff/dart-latin-reader/releases/download/windows-preview/latin-reader-windows.zip). Unzip it and run `latin_reader\latin_reader.exe`. It shares data and settings with your local Windows build.

### Contributors: from your PR

Every PR run produces downloadable builds. Open the run from your PR's checks and scroll to **Artifacts**.

- **Android:** download `latin-reader-apk-<number>`, a ZIP. Unzip it and install `app-release.apk`. It installs as **Latin Reader PR**.
  - Each PR build is signed with a throwaway key, so uninstall the previous Latin Reader PR before installing a newer one.
- **Windows:** download `app-release.exe`. Despite the name, it's a ZIP of the whole app folder. Unzip it and run `latin_reader.exe`; the other files next to it are required.

If GitHub Actions is enabled in your fork, runs there build the same way PR builds do (the APK installs as Latin Reader PR) and publish nothing. The checks that count are the ones on your PR here.

### Owner: any branch

Starting a workflow by hand needs write access to the repo.

- **Android:**
  1. Run `gh workflow run android.yml --ref <branch>`.
  2. Download `latin-reader-apk-<number>` from that run.
  3. It installs as **Latin Reader Preview**, over the current preview.
- **Windows:** run `gh workflow run windows.yml --ref <branch>`, then download `app-release.exe` from that run.

The Windows build shares data and settings with your local Windows build, because it's the same app to Windows.

## Version numbers

- **Build number:** set automatically by GitHub on Android builds. Nothing to do.
- **Visible version (`1.0.0`):** the part before `+` in `version:` in `pubspec.yaml`. Change it by hand.

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
- NOTE: Not a Play Store key. Windows builds aren't signed.

A PR from a first-time contributor may wait for my approval: open the run in the Actions tab and choose **Approve and run**.