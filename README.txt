LEATRIX PLUS - VANILLA 1.12.1 ALL-IN-ONE EDITION
================================================

This is a self-contained Interface 11200 build for the original World of
Warcraft 1.12.1 client.  It combines the working Leatrix compatibility
features with the useful systems from LazyPig 5.32.  _LazyPig is NOT required.

INSTALLATION
------------
1. Exit World of Warcraft completely.
2. Delete or move both old folders if present:
     Interface\AddOns\Leatrix_Plus
     Interface\AddOns\_LazyPig
3. Extract this ZIP into Interface\AddOns.
4. Confirm this file exists exactly here:
     Interface\AddOns\Leatrix_Plus\Leatrix_Plus.toc
5. Start WoW, enable Leatrix Plus (1.12 Fix), and type /ltp.

Do not nest Leatrix_Plus inside another Leatrix_Plus folder.  Do not enable
the separate _LazyPig addon at the same time; its hooks would duplicate and
conflict with the merged features.

ALL-IN-ONE FEATURES
-------------------
Original Leatrix compatibility features:
- Quest and gossip automation with safe choice/payment stopping
- Summon, resurrection and battleground release automation
- Junk selling and equipment repair
- Duel and party invite filtering; friend/guild acceptance
- Optional stranger-invite acceptance and battleground/queue pause rules
- Whisper-keyword invites
- Chat history, fade, sticky, edit-box, combat-log and button controls
- Minimap zoom/scale; action-bar gryphon and stance-bar controls
- Draggable minimap icon constrained to the minimap rim (right-click resets it)
- Screen glow/death effects, camera distance, fast loot and dismount help
- Optional always-auto-loot: right-click loots all; Shift opens manual loot
- Multi-pass Vanilla loot timing handles clients that populate slots late

Merged LazyPig tool families:
- Battleground queue, entry, exit and group queue announcements
- Battleground quest-share blocking
- WSG enemy flag-carrier tracking and flag/Slow Fall removal keybinds
- Repeatable quest recording and replay
- ZG coin/bijou Need, Greed or Pass automation
- Ctrl+Alt uncommon-item Need, Greed or Pass action
- Loot window under the cursor
- Improved right-click for trade, mail and auction attachments
- Easy stack split/merge mode (Shift-right-click; Ctrl down, Alt up)
- Enemy/friendly nameplate rules
- Zone-aware World-channel muting
- Duplicate public-chat and loot-roll filtering
- Blessing of Salvation removal (always or tank-only)
- Optional Ctrl/Alt/Shift action combinations
- Optional private-server .save automation
- Logout, unstuck, reload, WSG and menu key bindings

SAFETY AND DEFAULTS
-------------------
Every option defaults to OFF, including all imported LazyPig automation.
This avoids surprise battleground entry, loot rolls, popup confirmation or
private-server commands.  Configure only the actions you want in /ltp.

The Recommended button applies a conservative starter profile: useful chat
behavior, automatic junk selling and repairs, maximum camera distance, automatic
and cursor-positioned loot, dismount help, and duplicate-spam filtering.  It
deliberately leaves quests, queues, rolls, invites, special keys and .save off.

Special key combinations are intentionally opt-in:
- Ctrl+Shift: follow a friendly player target
- Alt+Shift: inspect a player, or bid in the auction browse panel
- Ctrl+Alt: green roll, trade, confirm/send, or auction action by context
- Ctrl+Alt+Shift: log out
- Hold Shift while targeting yourself for three seconds: open battleground UI

Easy stack mode:
1. Shift-right-click a bag stack once to open the nine-second stack control.
2. Hold Alt to increase the target amount or Ctrl to decrease it.
3. Shift-right-click a stack to split or merge matching items to that amount.

Repeatable quest recorder:
1. Enable Repeatable quest recorder on the Tools page.
2. Hold Shift and manually select the repeatable quest once.
3. Future visits select and complete that recorded quest automatically.
4. Use /ltp repeat clear to forget it.

COMMANDS
--------
/ltp                    Open or close options
/ltp help               Show command help
/ltp keyword WORD       Change the whisper-invite keyword
/ltp repeat             Show the recorded repeatable quest
/ltp repeat clear       Forget the recorded repeatable quest
/ltp reset              Turn every option off
/reload                 Reload the user interface
/rl                     Short reload alias
/reloadui               Alternate reload alias

CREDITS
-------
LazyPig feature concepts and compatible source behavior are credited to
Ogrisch and mrmr, authors of the supplied LazyPig 5.32 addon.  The interface
uses a compact dark-glass and gold-accent style inspired by the supplied
Zygor viewer while relying only on built-in WoW textures.
