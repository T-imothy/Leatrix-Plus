# Leatrix Plus

This repository tracks the maintained Leatrix Plus addon builds for three game eras.

## Branches

- `classic` — Classic 1.12.1
- `tbc` — The Burning Crusade 2.4.3
- `wotlk` — Wrath of the Lich King 3.3.5a

Each branch contains the addon files at the repository root so the branch matches the contents packaged into `Leatrix_Plus.zip`.

## Release workflow

1. Make and validate the addon change in the matching era source.
2. Publish the verified ZIP to R2 and regenerate the matching addon catalog.
3. Confirm the R2 publish and catalog update succeeded.
4. Commit the exact published source to the corresponding GitHub branch.

The GitHub commit is made only after the release publish is verified, keeping the branch synchronized with the downloadable build.
