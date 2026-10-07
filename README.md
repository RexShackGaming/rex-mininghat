# rex-mininghat

A wearable mining hat with a working lamp for **RedM** servers running the **RSG-Core** framework.

## Features

- Usable `mininghat` inventory item that toggles the hat on and off
- Attaches a miner's helmet prop to the player's head
- Optional lamp/projector prop on the hat
- Removed automatically when the player:
  - no longer has the item
  - dies
  - logs out / unloads
  - stops the resource
- Re-attaches automatically if the ped changes (e.g. clothing/model reload)
- ox_lib notifications
- Translated with ox_lib locales: `en`, `de`, `el`, `es`, `fr`, `ja`, `nl`, `pl`, `pt-br`, `ro`
- Version checker on resource start

## Dependencies

- [rsg-core](https://github.com/Rexshack-RedM/rsg-core)
- [ox_lib](https://github.com/Rexshack-RedM/ox_lib)

## Installation

1. Put the `rex-mininghat` folder in your server's `resources` folder.
2. Add the item to `rsg-core/shared/items.lua` (see `installation/shared_items.lua`):
   ```lua
   mininghat = { name = 'mininghat', label = 'Mining Hat', weight = 500, type = 'item', image = 'mininghat.png', unique = false, useable = true, shouldClose = true, category = 'tools', description = 'A miner\'s hat with a lamp' },
   ```
3. Copy `installation/images/mininghat.png` into your inventory images folder (e.g. `rsg-inventory/html/images/`).
4. Add to your `server.cfg`, after `rsg-core` and `ox_lib`:
   ```cfg
   ensure rex-mininghat
   ```
5. Restart your server.

## Configuration

Edit `shared/config.lua`:

| Option | Default | Description |
|---|---|---|
| `Config.Item` | `'mininghat'` | Name of the usable item |
| `Config.UseProjector` | `true` | Attach the lamp/projector prop to the hat |
| `Config.Bone` | `'HairScale_B'` | Ped bone the hat attaches to |
| `Config.HatModel` | `'s_hat_miner01x'` | Hat prop model |
| `Config.ProjectorModel` | `'s_movieprojection01x'` | Lamp prop model |
| `Config.HatOffset` | `{ 0.0, -0.03, 0.01, -9.0, 4.0, 0.0 }` | Hat offset: x, y, z, rotX, rotY, rotZ |
| `Config.ProjectorOffset` | `{ 0.01, -0.070, 0.09, -80.0, 16.0, 4.0 }` | Lamp offset: x, y, z, rotX, rotY, rotZ |

### Language

Set the ox_lib locale in `server.cfg`, for example:
```cfg
setr ox:locale en
```
The text is stored in `locales/*.json`. To add a language, copy `en.json` to a new file and translate it.

## Usage

1. Get a **Mining Hat** item (shop, crafting, or admin: `/giveitem [id] mininghat 1`).
2. Use the item from your inventory to put the hat on.
3. Use it again to take it off.

The hat comes off if you drop or lose the item, die, or log out.

## Credits

- Rexshack-RedM

## Support

If you like this script, you can support development here:

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-ffdd00?style=for-the-badge&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/rexshack)
