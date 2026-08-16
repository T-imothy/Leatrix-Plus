# Leatrix Plus

Leatrix Plus is an all-in-one quality-of-life addon for legacy World of Warcraft clients. It combines practical automation, interface controls, chat tools, loot helpers, travel utilities, and other conveniences in one configurable addon.

Developed by Tim.

## Supported game versions

| Branch | Game client | Interface | Addon version |
| --- | --- | ---: | --- |
| [`classic`](../../tree/classic) | Vanilla 1.12.1 | 11200 | 1.12.1-allinone.29 |
| [`tbc`](../../tree/tbc) | The Burning Crusade 2.4.3 | 20400 | 2.4.3-allinone.4 |
| [`wotlk`](../../tree/wotlk) | Wrath of the Lich King 3.3.5a | 30300 | 3.3.5a-allinone.4 |

Choose the branch matching your game client before downloading the addon.

## Highlights

- Quest and gossip automation with safeguards for choices and payments
- Automatic junk selling and equipment repair
- Summon, resurrection, duel, party invite, and battleground helpers
- Chat history, sticky channels, spam filtering, and chat-window controls
- Minimap, action-bar, camera, nameplate, and screen-effect controls
- Loot helpers, cursor-positioned loot, and bag stack tools
- Flight progress and timing support
- Repeatable quest recording and replay
- Battleground announcements and flag-carrier tools
- Optional loot-roll, whisper-invite, and private-server conveniences
- Searchable settings and a conservative Recommended profile

Available features vary slightly by client era because each branch uses the APIs supported by that version of World of Warcraft.

## Installation

1. Open the branch for your game version.
2. Select **Code**, then **Download ZIP**.
3. Extract the addon into your game installation's `Interface/AddOns` folder.
4. Confirm the final path is:
   `Interface/AddOns/Leatrix_Plus/Leatrix_Plus.toc`
5. Restart the game or reload the user interface.

Avoid an extra nested folder such as `Leatrix_Plus/Leatrix_Plus`.

For the Classic all-in-one branch, do not enable the separate `_LazyPig` addon at the same time. Its overlapping hooks can duplicate or conflict with the integrated features.

## Usage

Open the settings window with:

```text
/ltp
```

Useful commands:

- `/ltp help` — show command help
- `/ltp reset` — turn all options off
- `/reload`, `/rl`, or `/reloadui` — reload the user interface

Most automation is opt-in. The **Recommended** button applies a conservative starter profile without enabling aggressive quest, queue, invite, loot-roll, or private-server automation.

## Compatibility

These branches target the original legacy client interfaces listed above. Install only the branch that matches your client version.

If an older copy is already installed, exit the game and replace the complete `Leatrix_Plus` folder rather than mixing files from different releases or game eras.

## Credits

The Classic all-in-one edition incorporates compatible LazyPig feature concepts and behavior credited to Ogrisch and mrmr.
