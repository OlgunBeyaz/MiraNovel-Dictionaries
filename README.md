# MiraNovel Dictionaries

Official community dictionary package catalog for **MiraNovel** (Rust / Tauri 2 / Svelte).

This repository hosts a machine-readable language catalog. Actual dictionary packages should be published as **GitHub Release assets**, not committed as large binary databases.

## How it works

1. MiraNovel downloads [catalog.json](catalog.json) from the `main` branch.
2. The user selects a language and clicks **Install**.
3. MiraNovel downloads a ZIP from an allowlisted GitHub Releases URL.
4. The Rust installer verifies the SHA-256 hash, checks the package format and SQLite integrity, then installs atomically into the platform-specific app-data directory.
5. Installed dictionaries remain usable offline.

**Current status:** No language packages have been published yet. The catalog is intentionally empty.

## Package layout

Each ZIP may contain:

```text
package.json
dict/
  dilek_en.db
  en_US.aff
  en_US.dic
LICENSES/
  SOURCE-LICENSE.txt
  ATTRIBUTION.txt
```

All package files are optional except `package.json`, but a package must contain at least one supported dictionary component. The filename examples are not published downloads.

## Releasing a dictionary

1. Confirm that the source license allows redistributing the dictionary in this form and record all attribution obligations.
2. Build and test the SQLite/Hunspell files.
3. Create a package manifest (see [example](examples/package-manifest.example.json)).
4. Include full applicable license texts and required attributions.
5. ZIP the package and publish it as a GitHub Release asset.
6. Calculate the SHA-256 of the final ZIP and add a catalog entry pointing to the exact versioned asset URL.
7. Verify install, update and rollback in MiraNovel on Windows, Linux and macOS.

## Security and compatibility

- Only allow HTTPS downloads from explicitly configured hosts and repository locations.
- Verify archive hash **before** extraction; reject path traversal, symlinks and oversized files.
- Check SQLite schema compatibility and `PRAGMA integrity_check`.
- Never write to the bundled Tauri `resources` directory at runtime.
- Keep user-added words in a separate writable database so updates never overwrite them.
- Display source licenses before installation when needed.

Repository content and package data may use **different licenses**. Each imported dataset retains its original terms. Do not upload scraped third-party dictionaries without redistribution permission.

## Catalog URL

`https://raw.githubusercontent.com/OlgunBeyaz/MiraNovel-Dictionaries/main/catalog.json`
