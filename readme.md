# 💨 Roll Coal Script (ox_lib) - Made by lowkeypapa

A simple, optimized FiveM script that allows specific players to "Roll Coal" (emit black smoke) from their vehicle exhausts. This script uses **ox_lib** for the interface and **ACE Permissions** for server-side security.

## ✨ Features
* **ACE Permission Restricted:** Only allowed players/groups can open the menu.
* **Whitelist Logic:** Players must "Add" their specific truck via the menu to enable the effect (prevents accidentally rolling coal in sedans/sports cars).
* **Realistic Effects:** Uses density-scaled black particles.
* **Smart Exhaust Detection:** Automatically detects multiple exhausts (works on trucks with dual stacks).
* **Performance Friendly:** Particles are removed automatically after 3 seconds.

## 📋 Requirements
* [ox_lib](https://github.com/overextended/ox_lib) (Must be started before this script)
* FiveM Server (Artifacts 4752+ recommended for Lua 5.4)

## 🛠️ Installation

1.  **Download/Create Resource:**
    * Create a folder named `rollcoal` (or whatever you prefer) in your `resources` directory.
    * Ensure you have `fxmanifest.lua`, `server.lua`, and `client.lua` inside.

2.  **Server Config:**
    * Open your `server.cfg`.
    * Ensure `ox_lib` is started.
    * Add `ensure rollcoal` (or your folder name).

    ```cfg
    ensure ox_lib
    ensure rollcoal
    ```

## 🔐 Permissions (ACE)

By default, nobody can use the `/coalmenu` command. You must assign the `coal.use` permission in your `server.cfg`.

**Option 1: Allow all Admins**
```cfg
add_ace group.admin coal.use allow